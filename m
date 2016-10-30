From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 02/11] locking/osq: Drop the overload of osq_lock()
Date: Sun, 30 Oct 2016 22:39:29 +0800
Message-ID: <3b93d48e-a106-01ec-3367-b244bd659d2f@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161029165216.GA17451@linux-80c1.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161029165216.GA17451@linux-80c1.suse>
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
To: Davidlohr Bueso <dave@stgolabs.net>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, mpe@ellerman.id.au, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

CgrlnKggMjAxNi8xMC8zMCAwMDo1MiwgRGF2aWRsb2hyIEJ1ZXNvIOWGmemBkzoKPiBPbiBGcmks
IDI4IE9jdCAyMDE2LCBQYW4gWGluaHVpIHdyb3RlOgo+PiAgICAgICAgIC8qCj4+ICAgICAgICAg
ICogSWYgd2UgbmVlZCB0byByZXNjaGVkdWxlIGJhaWwuLi4gc28gd2UgY2FuIGJsb2NrLgo+PiAr
ICAgICAgICAgKiBVc2UgdmNwdV9pc19wcmVlbXB0ZWQgdG8gZGV0ZWNoIGxvY2sgaG9sZGVyIHBy
ZWVtcHRpb24gaXNzdWUKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXl4gZGV0ZWN0Cm9rLiB0aGFua3MgZm9yIHBvaW5ndGluZyBpdCBvdXQuCj4+ICsgICAgICAg
ICAqIGFuZCBicmVhay4KPgo+IENvdWxkIHlvdSBwbGVhc2UgcmVtb3ZlIHRoZSByZXN0IG9mIHRo
aXMgY29tbWVudD8gSXRzIGp1c3Qgbm9pc2UgdG8gcG9pbnQgb3V0Cj4gdGhhdCB2Y3B1X2lzX3By
ZWVtcHRlZCBpcyBhIG1hY3JvIGRlZmluZWQgYnkgYXJjaC9mYWxzZS4gVGhpcyBpcyBzdGFuZGFy
ZCBwcm90b2NvbAo+IGluIHRoZSBrZXJuZWwuCj4KZmFpciBlbm91Z2guCgo+IFNhbWUgZ29lcyBm
b3IgYWxsIGxvY2tzIHlvdSBjaGFuZ2Ugd2l0aCB0aGlzLgo+Cj4gVGhhbmtzLAo+IERhdmlkbG9o
cgo+Cj4+ICAgICAgICAgICAgICAgICogdmNwdV9pc19wcmVlbXB0ZWQgaXMgYSBtYWNybyBkZWZp
bmVkIGJ5IGZhbHNlIGlmCj4+ICsgICAgICAgICAqIGFyY2ggZG9lcyBub3Qgc3VwcG9ydCB2Y3B1
IHByZWVtcHRlZCBjaGVjaywKPj4gICAgICAgICAgKi8KPj4gLSAgICAgICAgaWYgKG5lZWRfcmVz
Y2hlZCgpKQo+PiArICAgICAgICBpZiAobmVlZF9yZXNjaGVkKCkgfHwgdmNwdV9pc19wcmVlbXB0
ZWQobm9kZV9jcHUobm9kZS0+cHJldikpKQo+PiAgICAgICAgICAgICBnb3RvIHVucXVldWU7Cj4+
Cj4+ICAgICAgICAgY3B1X3JlbGF4X2xvd2xhdGVuY3koKTsKPj4gLS0KPj4gMi40LjExCj4+Cj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
