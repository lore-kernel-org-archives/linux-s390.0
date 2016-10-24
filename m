From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu preempted
	check
Date: Mon, 24 Oct 2016 10:46:54 +0800
Message-ID: <580D761E.5000508@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
	<20161021183951.GA29131@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161021183951.GA29131@potion>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "rkrcmar@redhat.com" <rkrcmar@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: "kernellwp@gmail.com" <kernellwp@gmail.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "jgross@suse.com" <jgross@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

CgpPbiAyMDE25bm0MTDmnIgyMuaXpSAwMjozOSwgcmtyY21hckByZWRoYXQuY29tIHdyb3RlOgo+
IDIwMTYtMTAtMjEgMTE6MjcrMDAwMCwgRGF2aWQgTGFpZ2h0Ogo+PiBGcm9tOiBQYW4gWGluaHVp
Cj4+PiBTZW50OiAyMCBPY3RvYmVyIDIwMTYgMjI6MjgKPj4+IENvbW1pdCAoIng4Niwga3ZtOiBz
dXBwb3J0IHZjcHUgcHJlZW1wdGVkIGNoZWNrIikgYWRkIG9uZSBmaWVsZCAiX191OAo+Pj4gcHJl
ZW1wdGVkIiBpbnRvIHN0cnVjdCBrdm1fc3RlYWxfdGltZS4gVGhpcyBmaWVsZCB0ZWxscyBpZiBv
bmUgdmNwdSBpcwo+Pj4gcnVubmluZyBvciBub3QuCj4+Pgo+Pj4gSXQgaXMgemVybyBpZiAxKSBz
b21lIG9sZCBLVk0gZGVvcyBub3Qgc3VwcG9ydCB0aGlzIGZpbGVkLiAyKSB0aGUgdmNwdSBpcwo+
Pj4gcHJlZW1wdGVkLiBPdGhlciB2YWx1ZXMgbWVhbnMgdGhlIHZjcHUgaGFzIGJlZW4gcHJlZW1w
dGVkLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFBhbiBYaW5odWkgPHhpbmh1aS5wYW5AbGludXgu
dm5ldC5pYm0uY29tPgo+Pj4gLS0tCj4+PiAgIERvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNy
LnR4dCB8IDggKysrKysrKy0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwv
a3ZtL21zci50eHQgYi9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQKPj4+IGluZGV4
IDJhNzFjOGYuLjMzNzZmMTMgMTAwNjQ0Cj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwv
a3ZtL21zci50eHQKPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4dAo+
Pj4gQEAgLTIwOCw3ICsyMDgsOCBAQCBNU1JfS1ZNX1NURUFMX1RJTUU6IDB4NGI1NjRkMDMKPj4+
ICAgCQlfX3U2NCBzdGVhbDsKPj4+ICAgCQlfX3UzMiB2ZXJzaW9uOwo+Pj4gICAJCV9fdTMyIGZs
YWdzOwo+Pj4gLQkJX191MzIgcGFkWzEyXTsKPj4+ICsJCV9fdTggIHByZWVtcHRlZDsKPj4+ICsJ
CV9fdTMyIHBhZFsxMV07Cj4+PiAgIAl9Cj4+Cj4+IEkgdGhpbmsgSSdkIGJlIGV4cGxpY2l0IGFi
b3V0IHRoZSAzIHBhZCBieXRlcyB5b3UndmUgbGVmdC4KPgo+IFNlY29uZGVkLgo+Cj4gV2l0aCB0
aGF0IGNoYW5nZSBhcmUgYWxsIEtWTSBiaXRzCj4KbGlrZSBiZWxvdz8KX191OCBwcmVlbXB0ZWQ7
Cl9fdTgga3ZtX3BhZFszXTsKCgo+IEFja2VkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJA
cmVkaGF0LmNvbT4KPgp0aGFua3MhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
