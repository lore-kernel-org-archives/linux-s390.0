Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
 <300d4404-3efe-880e-ef30-692eabbff5f7@de.ibm.com>
From: Alexander Graf <graf@amazon.de>
Message-ID: <da1a1fa7-a1de-d0e6-755b-dd587687765e@amazon.de>
Date: Thu, 19 Nov 2020 13:51:18 +0100
MIME-Version: 1.0
In-Reply-To: <300d4404-3efe-880e-ef30-692eabbff5f7@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Catangiu, Adrian Costin" <acatan@amazon.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jann Horn <jannh@google.com>
Cc: Willy Tarreau <w@1wt.eu>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-s390 <linux-s390@vger.kernel.org>, "areber@redhat.com" <areber@redhat.com>, Pavel Emelyanov <ovzxemul@gmail.com>, Andrey Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, "gil@azul.com" <gil@azul.com>, "asmehra@redhat.com" <asmehra@redhat.com>, "dgunigun@redhat.com" <dgunigun@redhat.com>, "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>

CgpPbiAxOS4xMS4yMCAxMzowMiwgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdyb3RlOgo+IAo+IE9u
IDE2LjExLjIwIDE2OjM0LCBDYXRhbmdpdSwgQWRyaWFuIENvc3RpbiB3cm90ZToKPj4gLSBCYWNr
Z3JvdW5kCj4+Cj4+IFRoZSBWTSBHZW5lcmF0aW9uIElEIGlzIGEgZmVhdHVyZSBkZWZpbmVkIGJ5
IE1pY3Jvc29mdCAocGFwZXI6Cj4+IGh0dHA6Ly9nby5taWNyb3NvZnQuY29tL2Z3bGluay8/TGlu
a0lkPTI2MDcwOSkgYW5kIHN1cHBvcnRlZCBieQo+PiBtdWx0aXBsZSBoeXBlcnZpc29yIHZlbmRv
cnMuCj4+Cj4+IFRoZSBmZWF0dXJlIGlzIHJlcXVpcmVkIGluIHZpcnR1YWxpemVkIGVudmlyb25t
ZW50cyBieSBhcHBzIHRoYXQgd29yawo+PiB3aXRoIGxvY2FsIGNvcGllcy9jYWNoZXMgb2Ygd29y
bGQtdW5pcXVlIGRhdGEgc3VjaCBhcyByYW5kb20gdmFsdWVzLAo+PiB1dWlkcywgbW9ub3Rvbmlj
YWxseSBpbmNyZWFzaW5nIGNvdW50ZXJzLCBldGMuCj4+IFN1Y2ggYXBwcyBjYW4gYmUgbmVnYXRp
dmVseSBhZmZlY3RlZCBieSBWTSBzbmFwc2hvdHRpbmcgd2hlbiB0aGUgVk0KPj4gaXMgZWl0aGVy
IGNsb25lZCBvciByZXR1cm5lZCB0byBhbiBlYXJsaWVyIHBvaW50IGluIHRpbWUuCj4+Cj4+IFRo
ZSBWTSBHZW5lcmF0aW9uIElEIGlzIGEgc2ltcGxlIGNvbmNlcHQgbWVhbnQgdG8gYWxsZXZpYXRl
IHRoZSBpc3N1ZQo+PiBieSBwcm92aWRpbmcgYSB1bmlxdWUgSUQgdGhhdCBjaGFuZ2VzIGVhY2gg
dGltZSB0aGUgVk0gaXMgcmVzdG9yZWQKPj4gZnJvbSBhIHNuYXBzaG90LiBUaGUgaHcgcHJvdmlk
ZWQgVVVJRCB2YWx1ZSBjYW4gYmUgdXNlZCB0bwo+PiBkaWZmZXJlbnRpYXRlIGJldHdlZW4gVk1z
IG9yIGRpZmZlcmVudCBnZW5lcmF0aW9ucyBvZiB0aGUgc2FtZSBWTS4KPj4KPj4gLSBQcm9ibGVt
Cj4+Cj4+IFRoZSBWTSBHZW5lcmF0aW9uIElEIGlzIGV4cG9zZWQgdGhyb3VnaCBhbiBBQ1BJIGRl
dmljZSBieSBtdWx0aXBsZQo+PiBoeXBlcnZpc29yIHZlbmRvcnMgYnV0IG5laXRoZXIgdGhlIHZl
bmRvcnMgb3IgdXBzdHJlYW0gTGludXggaGF2ZSBubwo+PiBkZWZhdWx0IGRyaXZlciBmb3IgaXQg
bGVhdmluZyB1c2VycyB0byBmZW5kIGZvciB0aGVtc2VsdmVzLgo+IAo+IEkgc2VlIHRoYXQgdGhl
IHFlbXUgaW1wbGVtZW50YXRpb24gaXMgc3RpbGwgdW5kZXIgZGlzY3Vzc2lvbi4gV2hhdCBpcwoK
VWgsIHRoZSBBQ1BJIFZtZ2VuaWQgZGV2aWNlIGVtdWxhdGlvbiBpcyBpbiBRRU1VIHNpbmNlIDIu
OS4wIDopLgoKPiB0aGUgc3RhdHVzIG9mIHRoZSBvdGhlciBleGlzdGluZyBpbXBsZW1lbnRhdGlv
bnMuIERvIHRoZXkgYWxyZWFkeSBleGlzdD8KPiBJbiBvdGhlciB3b3JkcyBpcyBBQ1BJIGEgZ2l2
ZW4/Cj4gSSB0aGluayB0aGUgbWFqb3JpdHkgb2YgdGhpcyBkcml2ZXIgY291bGQgYmUgdXNlZCB3
aXRoIGp1c3QgYSBkaWZmZXJlbnQKPiBiYWNrZW5kIGZvciBwbGF0Zm9ybXMgd2l0aG91dCBBQ1BJ
IHNvIGluIGFueSBjYXNlIHdlIGNvdWxkIGZhY3RvciBvdXQKPiB0aGUgYmFja2VuZCAoYWNwaSwg
dmlydGlvLCB3aGF0ZXZlcikgYnV0IGlmIHdlIGFyZSBvcGVuIHdlIGNvdWxkIG1heWJlCj4gc3Rh
cnQgd2l0aCBzb21ldGhpbmcgZWxzZS4KCkkgYWdyZWUgMTAwJS4gSSBkb24ndCB0aGluayB3ZSBy
ZWFsbHkgbmVlZCBhIG5ldyBmcmFtZXdvcmsgaW4gdGhlIGtlcm5lbCAKZm9yIHRoYXQuIFdlIGNh
biBqdXN0IGhhdmUgZm9yIGV4YW1wbGUgYW4gczM5MHggc3BlY2lmaWMgZHJpdmVyIHRoYXQgCmFs
c28gcHJvdmlkZXMgdGhlIHNhbWUgbm90aWZpY2F0aW9uIG1lY2hhbmlzbSB0aHJvdWdoIGEgZGV2
aWNlIG5vZGUgdGhhdCAKaXMgYWxzbyBuYW1lZCAiL2Rldi92bWdlbmlkIiwgbm8/CgpPciBhbHRl
cm5hdGl2ZWx5IHdlIGNhbiBzcGxpdCB0aGUgZ2VuZXJpYyBwYXJ0IG9mIHRoaXMgZHJpdmVyIGFz
IHNvb24gYXMgCmEgc2Vjb25kIG9uZSBjb21lcyBhbG9uZyBhbmQgdGhlbiBoYXZlIGJvdGggZHJp
dmVyIGluY2x1ZGUgdGhhdCBnZW5lcmljIApsb2dpYy4KClRoZSBvbmx5IHBpZWNlIHdoZXJlIEkn
bSB1bnN1cmUgaXMgaG93IHRoaXMgd2lsbCBpbnRlcmFjdCB3aXRoIENSSVUuIENhbiAKY29udGFp
bmVycyBlbXVsYXRlIGlvY3RscyBhbmQgZGV2aWNlIG5vZGVzPwoKCkFsZXgKCgoKQW1hem9uIERl
dmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MK
RWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3
MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK
