From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Tue, 25 Oct 2016 09:25:37 +0800
Message-ID: <2f37742f-6839-1ef4-0838-05fb7222f14a@linux.vnet.ibm.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161019172403.GA9240@potion>
	<c00e636e-ea06-6bbb-6a67-39804ee8ba75@redhat.com>
	<20161024151417.GC2247@potion>
	<1a556fcf-e071-8c32-7a4b-ca7a2ffc17e9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1a556fcf-e071-8c32-7a4b-ca7a2ffc17e9@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

CgrlnKggMjAxNi8xMC8yNCAyMzoxOCwgUGFvbG8gQm9uemluaSDlhpnpgZM6Cj4KPgo+IE9uIDI0
LzEwLzIwMTYgMTc6MTQsIFJhZGltIEtyxI1tw6HFmSB3cm90ZToKPj4gMjAxNi0xMC0yNCAxNjoz
OSswMjAwLCBQYW9sbyBCb256aW5pOgo+Pj4gT24gMTkvMTAvMjAxNiAxOToyNCwgUmFkaW0gS3LE
jW3DocWZIHdyb3RlOgo+Pj4+Pj4gKwlpZiAodmNwdS0+YXJjaC5zdC5tc3JfdmFsICYgS1ZNX01T
Ul9FTkFCTEVEKQo+Pj4+Pj4gKwkJaWYgKGt2bV9yZWFkX2d1ZXN0X2NhY2hlZCh2Y3B1LT5rdm0s
ICZ2Y3B1LT5hcmNoLnN0LnN0aW1lLAo+Pj4+Pj4gKwkJCQkJJnZjcHUtPmFyY2guc3Quc3RlYWws
Cj4+Pj4+PiArCQkJCQlzaXplb2Yoc3RydWN0IGt2bV9zdGVhbF90aW1lKSkgPT0gMCkgewo+Pj4+
Pj4gKwkJCXZjcHUtPmFyY2guc3Quc3RlYWwucHJlZW1wdGVkID0gMTsKPj4+Pj4+ICsJCQlrdm1f
d3JpdGVfZ3Vlc3RfY2FjaGVkKHZjcHUtPmt2bSwgJnZjcHUtPmFyY2guc3Quc3RpbWUsCj4+Pj4+
PiArCQkJCQkmdmNwdS0+YXJjaC5zdC5zdGVhbCwKPj4+Pj4+ICsJCQkJCXNpemVvZihzdHJ1Y3Qg
a3ZtX3N0ZWFsX3RpbWUpKTsKPj4+Pj4+ICsJCX0KPj4+PiBQbGVhc2UgbmFtZSB0aGlzIGJsb2Nr
IG9mIGNvZGUuICBTb21ldGhpbmcgbGlrZQo+Pj4+ICAga3ZtX3N0ZWFsX3RpbWVfc2V0X3ByZWVt
cHRlZCh2Y3B1KTsKPj4+Cj4+PiBXaGlsZSBhdCBpdDoKPj4+Cj4+PiAxKSB0aGUga3ZtX3JlYWRf
Z3Vlc3RfY2FjaGVkIGlzIG5vdCBuZWNlc3NhcnkuICBZb3UgY2FuIHJpZyB0aGUgY2FsbCB0bwo+
Pj4ga3ZtX3dyaXRlX2d1ZXN0X2NhY2hlZCBzbyB0aGF0IGl0IG9ubHkgd3JpdGVzIHZjcHUtPmFy
Y2guc3Quc3RlYWwucHJlZW1wdGVkLgo+Pgo+PiBJIGFncmVlLiAga3ZtX3dyaXRlX2d1ZXN0X2Nh
Y2hlZCgpIGFsd2F5cyB3cml0ZXMgZnJvbSBvZmZzZXQgMCwgc28gd2UnZAo+PiB3YW50IGEgbmV3
IGZ1bmN0aW9uIHRoYXQgYWxsb3dzIHRvIHNwZWNpZnkgYSBzdGFydGluZyBvZmZzZXQuCj4KPiBZ
ZWFoLCBsZXQncyBsZWF2ZSBpdCBmb3IgYSBmb2xsb3ctdXAgdGhlbiEKPgpJIHRoaW5rIEkgY2Fu
IG1ha2UgYSBoYXZpbmctb2Zmc2V0IHZlcnNpb24uIDopCgo+IFRoYW5rcywKPgo+IFBhb2xvCj4K
Pj4gVXNpbmcgY2FjaGVkIHZjcHUtPmFyY2guc3Quc3RlYWwgdG8gYXZvaWQgdGhlIHJlYWQgd291
bGRuJ3QgYmUgYXMgZ29vZC4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
