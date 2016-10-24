From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu preempted
	check
Date: Mon, 24 Oct 2016 10:44:45 +0800
Message-ID: <580D759D.4000304@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
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
To: David Laight <David.Laight@ACULAB.COM>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "kernellwp@gmail.com" <kernellwp@gmail.com>, "jgross@suse.com" <jgross@suse.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

CgpPbiAyMDE25bm0MTDmnIgyMeaXpSAxOToyNywgRGF2aWQgTGFpZ2h0IHdyb3RlOgo+IEZyb206
IFBhbiBYaW5odWkKPj4gU2VudDogMjAgT2N0b2JlciAyMDE2IDIyOjI4Cj4+IENvbW1pdCAoIng4
Niwga3ZtOiBzdXBwb3J0IHZjcHUgcHJlZW1wdGVkIGNoZWNrIikgYWRkIG9uZSBmaWVsZCAiX191
OAo+PiBwcmVlbXB0ZWQiIGludG8gc3RydWN0IGt2bV9zdGVhbF90aW1lLiBUaGlzIGZpZWxkIHRl
bGxzIGlmIG9uZSB2Y3B1IGlzCj4+IHJ1bm5pbmcgb3Igbm90Lgo+Pgo+PiBJdCBpcyB6ZXJvIGlm
IDEpIHNvbWUgb2xkIEtWTSBkZW9zIG5vdCBzdXBwb3J0IHRoaXMgZmlsZWQuIDIpIHRoZSB2Y3B1
IGlzCj4+IHByZWVtcHRlZC4gT3RoZXIgdmFsdWVzIG1lYW5zIHRoZSB2Y3B1IGhhcyBiZWVuIHBy
ZWVtcHRlZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogUGFuIFhpbmh1aSA8eGluaHVpLnBhbkBsaW51
eC52bmV0LmlibS5jb20+Cj4+IC0tLQo+PiAgIERvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNy
LnR4dCB8IDggKysrKysrKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3Zt
L21zci50eHQgYi9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQKPj4gaW5kZXggMmE3
MWM4Zi4uMzM3NmYxMyAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9t
c3IudHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4dAo+PiBAQCAt
MjA4LDcgKzIwOCw4IEBAIE1TUl9LVk1fU1RFQUxfVElNRTogMHg0YjU2NGQwMwo+PiAgIAkJX191
NjQgc3RlYWw7Cj4+ICAgCQlfX3UzMiB2ZXJzaW9uOwo+PiAgIAkJX191MzIgZmxhZ3M7Cj4+IC0J
CV9fdTMyIHBhZFsxMl07Cj4+ICsJCV9fdTggIHByZWVtcHRlZDsKPj4gKwkJX191MzIgcGFkWzEx
XTsKPj4gICAJfQo+Cj4gSSB0aGluayBJJ2QgYmUgZXhwbGljaXQgYWJvdXQgdGhlIDMgcGFkIGJ5
dGVzIHlvdSd2ZSBsZWZ0Lgo+CnllcyxJICB3aWxsIGRvIGl0IGluIG5leHQgdmVyc2lvbi4KCnRo
YW5rcwoKPiAJRGF2aWQKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
