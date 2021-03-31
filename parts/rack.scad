node_count=3;
space_between_nodes=30;
rack_width=20;
rack_depth=70;
slot_depth=2;
slot_length=65;
power_feed_width=10;

module insert_slots(count) {
    for(i=[0:count-1]) {
        translate([0, 0, space_between_nodes * i + space_between_nodes/2])
            cube(
                size=[
                    slot_depth,
                    slot_length,
                    slot_depth
                ],
                center=false
            );

        translate([rack_width-slot_depth , 0, space_between_nodes * i + space_between_nodes/2])
            cube(
                size=[
                    slot_depth,
                    slot_length,
                    slot_depth
                ],
                center=false
            );
    }
}

module power_feed_hole(count) {
    for(i=[0:count-1]) {
        translate([0, space_between_nodes/2, space_between_nodes * i + space_between_nodes])
        rotate([0,90,0])
            cylinder(h=rack_width, r=10/2, center=false, $fn=36);

    }
}
module power_feed(count) {
    translate([rack_width/2 - power_feed_width / 2, 0, 0])
        cube(
            size=[
                power_feed_width,
                space_between_nodes / 2,
                space_between_nodes * node_count + space_between_nodes / 2 - (rack_width/2)
            ],
            center=false
        );

}


difference() {
    cube(
        size=[
            rack_width,
            rack_depth,
            space_between_nodes * node_count + space_between_nodes / 2
        ],
        center=false
    );
    color("orange") insert_slots(count=node_count);
    color("red") power_feed_hole(count=node_count);
    color("red") power_feed();
}