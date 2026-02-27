import json

def analyze_frames(file_path):
    with open(file_path, 'r') as f:
        data = json.load(f)

    frames = data.get('performance', {}).get('flutterFrames', [])
    targets = [386, 450] # Check other high build frames

    for frame in frames:
        if frame.get('number') in targets:
            print(f"--- Frame {frame['number']} Analysis ---")
            print(f"Elapsed: {frame.get('elapsed', 0)/1000}ms")
            print(f"Build: {frame.get('build', 0)/1000}ms")
            print(f"Raster: {frame.get('raster', 0)/1000}ms")
            
            timeline_events = frame.get('timelineEvents', {})
            if not timeline_events:
                print("No timeline events found.")
                continue

            # Check UI events
            ui_events = timeline_events.get('ui')
            if ui_events:
                print("UI Root Event:", ui_events.get('name'))
                children = ui_events.get('children', [])
                if children:
                    print("Top UI Children:")
                    for child in children[:10]: # Increased to 10
                        if not child: continue
                        name = child.get('name', 'Unknown')
                        dur = (child.get('time', {}).get('end', 0) - child.get('time', {}).get('start', 0)) or 0
                        print(f"  {name}: {dur/1000}ms")
                        # Deep dive into BUILD if present
                        if name == 'BUILD':
                            grand_children = child.get('children', [])
                            for gc in grand_children[:5]:
                                dur_gc = (gc.get('time', {}).get('end', 0) - gc.get('time', {}).get('start', 0)) or 0
                                print(f"    {gc.get('name')}: {dur_gc/1000}ms")
            else:
                 print("No UI events found in timelineEvents.")
                 print("Available keys:", list(timeline_events.keys()))

if __name__ == "__main__":
    analyze_frames('/Users/elliottbrooks/dev/devtools_companion/flutter_frames.json')
