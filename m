From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Mon, 24 Oct 2016 17:14:18 +0200
Message-ID: <20161024151417.GC2247@potion>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161019172403.GA9240@potion>
	<c00e636e-ea06-6bbb-6a67-39804ee8ba75@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c00e636e-ea06-6bbb-6a67-39804ee8ba75@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

MjAxNi0xMC0yNCAxNjozOSswMjAwLCBQYW9sbyBCb256aW5pOgo+IE9uIDE5LzEwLzIwMTYgMTk6
MjQsIFJhZGltIEtyxI1tw6HFmSB3cm90ZToKPj4+ID4gKwlpZiAodmNwdS0+YXJjaC5zdC5tc3Jf
dmFsICYgS1ZNX01TUl9FTkFCTEVEKQo+Pj4gPiArCQlpZiAoa3ZtX3JlYWRfZ3Vlc3RfY2FjaGVk
KHZjcHUtPmt2bSwgJnZjcHUtPmFyY2guc3Quc3RpbWUsCj4+PiA+ICsJCQkJCSZ2Y3B1LT5hcmNo
LnN0LnN0ZWFsLAo+Pj4gPiArCQkJCQlzaXplb2Yoc3RydWN0IGt2bV9zdGVhbF90aW1lKSkgPT0g
MCkgewo+Pj4gPiArCQkJdmNwdS0+YXJjaC5zdC5zdGVhbC5wcmVlbXB0ZWQgPSAxOwo+Pj4gPiAr
CQkJa3ZtX3dyaXRlX2d1ZXN0X2NhY2hlZCh2Y3B1LT5rdm0sICZ2Y3B1LT5hcmNoLnN0LnN0aW1l
LAo+Pj4gPiArCQkJCQkmdmNwdS0+YXJjaC5zdC5zdGVhbCwKPj4+ID4gKwkJCQkJc2l6ZW9mKHN0
cnVjdCBrdm1fc3RlYWxfdGltZSkpOwo+Pj4gPiArCQl9Cj4+IFBsZWFzZSBuYW1lIHRoaXMgYmxv
Y2sgb2YgY29kZS4gIFNvbWV0aGluZyBsaWtlCj4+ICAga3ZtX3N0ZWFsX3RpbWVfc2V0X3ByZWVt
cHRlZCh2Y3B1KTsKPiAKPiBXaGlsZSBhdCBpdDoKPiAKPiAxKSB0aGUga3ZtX3JlYWRfZ3Vlc3Rf
Y2FjaGVkIGlzIG5vdCBuZWNlc3NhcnkuICBZb3UgY2FuIHJpZyB0aGUgY2FsbCB0bwo+IGt2bV93
cml0ZV9ndWVzdF9jYWNoZWQgc28gdGhhdCBpdCBvbmx5IHdyaXRlcyB2Y3B1LT5hcmNoLnN0LnN0
ZWFsLnByZWVtcHRlZC4KCkkgYWdyZWUuICBrdm1fd3JpdGVfZ3Vlc3RfY2FjaGVkKCkgYWx3YXlz
IHdyaXRlcyBmcm9tIG9mZnNldCAwLCBzbyB3ZSdkCndhbnQgYSBuZXcgZnVuY3Rpb24gdGhhdCBh
bGxvd3MgdG8gc3BlY2lmeSBhIHN0YXJ0aW5nIG9mZnNldC4KClVzaW5nIGNhY2hlZCB2Y3B1LT5h
cmNoLnN0LnN0ZWFsIHRvIGF2b2lkIHRoZSByZWFkIHdvdWxkbid0IGJlIGFzIGdvb2QuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
