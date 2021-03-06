use strict;
use warnings;
use Test::More tests => 22;
use PNI::Slot;

my $slot = PNI::Slot->new;
isa_ok $slot, 'PNI::Slot';

is $slot->data, undef, 'default data';
is $slot->node, undef, 'default node';

$slot->bang(1);
ok $slot->is_bang, 'is_bang';
ok $slot->bang,    'bang on';
$slot->bang(0);
ok !$slot->bang, 'bang off';

my $data = [
    qw(foo bar),
    { pinco => 'pallo' },
    'Nel mezzo del cammin di nostra vita, mi ritrovai per una selva oscura'
];
$slot->data($data);
is_deeply $slot->to_hashref,
  {
    id   => $slot->id,
    data => $data,
    type => $slot->type
  },
  'to_hashref';

$slot->data(1);
ok $slot->is_number, 'is_number';

$slot->data(0);
is $slot->type, 'SCALAR', 'zero has type SCALAR';
ok $slot->is_defined, '0 is_defined';

my $array = [];
$slot->data($array);
is $slot->type, ref $array, 'ARRAY type';
ok $slot->is_array, 'is_array';

my $code = sub { };
$slot->data($code);
is $slot->type, ref $code, 'CODE type';
ok $slot->is_code, 'is_code';

$slot->data(1);
ok $slot->is_defined, 'is_defined';

my $hash = {};
$slot->data($hash);
is $slot->type, ref $hash, 'HASH type';
ok $slot->is_hash, 'is_hash';

$slot->data('scalar');
is $slot->type, 'SCALAR', 'SCALAR type';
ok $slot->is_scalar, 'is_scalar';
ok $slot->is_string, 'is_string';

$slot->data(undef);
is $slot->type, 'UNDEF', 'UNDEF type';
ok $slot->is_undef, 'is_undef';

