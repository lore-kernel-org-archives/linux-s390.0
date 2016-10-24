From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
	preempted check
Date: Mon, 24 Oct 2016 16:42:37 +0200
Message-ID: <b2101564-6344-f353-7393-abc07f26c07a@redhat.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
	<20161021183951.GA29131@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: "kernellwp@gmail.com" <kernellwp@gmail.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "jgross@suse.com" <jgross@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 'Pan Xinhui' <xinhui.pan@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>, "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

CgpPbiAyMS8xMC8yMDE2IDIwOjM5LCBya3JjbWFyQHJlZGhhdC5jb20gd3JvdGU6Cj4gMjAxNi0x
MC0yMSAxMToyNyswMDAwLCBEYXZpZCBMYWlnaHQ6Cj4+IEZyb206IFBhbiBYaW5odWkKPj4+IFNl
bnQ6IDIwIE9jdG9iZXIgMjAxNiAyMjoyOAo+Pj4gQ29tbWl0ICgieDg2LCBrdm06IHN1cHBvcnQg
dmNwdSBwcmVlbXB0ZWQgY2hlY2siKSBhZGQgb25lIGZpZWxkICJfX3U4Cj4+PiBwcmVlbXB0ZWQi
IGludG8gc3RydWN0IGt2bV9zdGVhbF90aW1lLiBUaGlzIGZpZWxkIHRlbGxzIGlmIG9uZSB2Y3B1
IGlzCj4+PiBydW5uaW5nIG9yIG5vdC4KPj4+Cj4+PiBJdCBpcyB6ZXJvIGlmIDEpIHNvbWUgb2xk
IEtWTSBkZW9zIG5vdCBzdXBwb3J0IHRoaXMgZmlsZWQuIDIpIHRoZSB2Y3B1IGlzCj4+PiBwcmVl
bXB0ZWQuIE90aGVyIHZhbHVlcyBtZWFucyB0aGUgdmNwdSBoYXMgYmVlbiBwcmVlbXB0ZWQuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogUGFuIFhpbmh1aSA8eGluaHVpLnBhbkBsaW51eC52bmV0Lmli
bS5jb20+Cj4+PiAtLS0KPj4+ICBEb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQgfCA4
ICsrKysrKystCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50
eHQgYi9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQKPj4+IGluZGV4IDJhNzFjOGYu
LjMzNzZmMTMgMTAwNjQ0Cj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50
eHQKPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4dAo+Pj4gQEAgLTIw
OCw3ICsyMDgsOCBAQCBNU1JfS1ZNX1NURUFMX1RJTUU6IDB4NGI1NjRkMDMKPj4+ICAJCV9fdTY0
IHN0ZWFsOwo+Pj4gIAkJX191MzIgdmVyc2lvbjsKPj4+ICAJCV9fdTMyIGZsYWdzOwo+Pj4gLQkJ
X191MzIgcGFkWzEyXTsKPj4+ICsJCV9fdTggIHByZWVtcHRlZDsKPj4+ICsJCV9fdTMyIHBhZFsx
MV07Cj4+PiAgCX0KPj4KPj4gSSB0aGluayBJJ2QgYmUgZXhwbGljaXQgYWJvdXQgdGhlIDMgcGFk
IGJ5dGVzIHlvdSd2ZSBsZWZ0Lgo+IAo+IFNlY29uZGVkLgo+IAo+IFdpdGggdGhhdCBjaGFuZ2Ug
YXJlIGFsbCBLVk0gYml0cwo+IAo+IEFja2VkLWJ5OiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJA
cmVkaGF0LmNvbT4KClNhdyB0aGlzIGFmdGVyIHJlcGx5aW5nIHRvIHRoZSBwcmV2aW91cyBtZXNz
YWdlLiAgSWYgeW91IG5lZWQgdG8gcG9zdCB2NgpvZiB0aGUgZnVsbCBzZXJpZXMsIGl0IHdvdWxk
IGJlIG5pY2UgaWYgeW91IHJlbW92ZWQgdGhlCmt2bV9yZWFkX2d1ZXN0X2NhY2hlZC4gIEJ1dCBh
bnl3YXkgaXQgd2Fzbid0IG15IGludGVudGlvbiB0byBvdmVycmlkZSBSYWRpbS4KClBhb2xvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
