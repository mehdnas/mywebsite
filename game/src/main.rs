use bevy::prelude::*;
use bevy_skein::SkeinPlugin;

#[derive(Component, Reflect)]
#[reflect(Component)]
struct MyMeshMarker;

fn main() {
    App::new()
        .add_plugins((DefaultPlugins, SkeinPlugin::default()))
        .register_type::<MyMeshMarker>()
        .add_systems(Startup, setup)
        .add_systems(Update, mesh_movement)
        .run();
}

fn setup(mut commands: Commands, asset_server: ResMut<AssetServer>) {
    commands.spawn(SceneRoot(
        asset_server.load(GltfAssetLabel::Scene(0).from_asset("scene/scene.gltf")),
    ));
}

fn mesh_movement(time: Res<Time>, mut query: Query<&mut Transform, With<MyMeshMarker>>) {
    let delta = time.delta_secs();
    let rot = Quat::from_euler(EulerRot::XYZ, delta, delta, 0.0);
    for mut transform in &mut query {
        transform.rotation = rot * transform.rotation;
    }
}
