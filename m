From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
	vcpu preempted check
Date: Thu, 17 Nov 2016 13:16:30 +0800
Message-ID: <cc581449-81e4-1299-2221-0b1733648fb5@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161115154706.GF11311@worktop.programming.kicks-ass.net>
	<a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
	<20161116102355.GP3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161116102355.GP3142@twins.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, dave@stgolabs.net, mpe@ellerman.id.au, x86@kernel.org, mingo@redhat.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, konrad.wilk@oracle.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

CgrlnKggMjAxNi8xMS8xNiAxODoyMywgUGV0ZXIgWmlqbHN0cmEg5YaZ6YGTOgo+IE9uIFdlZCwg
Tm92IDE2LCAyMDE2IGF0IDEyOjE5OjA5UE0gKzA4MDAsIFBhbiBYaW5odWkgd3JvdGU6Cj4+IEhp
LCBQZXRlci4KPj4gCUkgdGhpbmsgd2UgY2FuIGF2b2lkIGEgZnVuY3Rpb24gY2FsbCBpbiBhIHNp
bXBsZXIgd2F5LiBIb3cgYWJvdXQgYmVsb3cKPj4KPj4gc3RhdGljIGlubGluZSBib29sIHZjcHVf
aXNfcHJlZW1wdGVkKGludCBjcHUpCj4+IHsKPj4gCS8qIG9ubHkgc2V0IGluIHB2IGNhc2UqLwo+
PiAJaWYgKHB2X2xvY2tfb3BzLnZjcHVfaXNfcHJlZW1wdGVkKQo+PiAJCXJldHVybiBwdl9sb2Nr
X29wcy52Y3B1X2lzX3ByZWVtcHRlZChjcHUpOwo+PiAJcmV0dXJuIGZhbHNlOwo+PiB9Cj4KPiBU
aGF0IGlzIHN0aWxsIG1vcmUgZXhwZW5zaXZlLiBJdCBuZWVkcyB0byBkbyBhbiBhY3R1YWwgbG9h
ZCBhbmQgbWFrZXMgaXQKPiBoYXJkIHRvIHByZWRpY3QgdGhlIGJyYW5jaCwgeW91J2QgaGF2ZSB0
byBhY3R1YWxseSB3YWl0IGZvciB0aGUgbG9hZCB0bwo+IGNvbXBsZXRlIGV0Yy4KPgp5ZXMsIG9u
ZSBtb3JlIGxvYWQgaW4gbmF0aXZlIGNhc2UuIEkgdGhpbmsgdGhpcyBpcyBhY2NlcHRhYmxlIGFz
IHZjcHVfaXNfcHJlZW1wdGVkIGlzIG5vdCBhIGNyaXRpY2FsIGZ1bmN0aW9uLgoKaG93ZXZlciBp
ZiB3ZSB1c2UgcHZfY2FsbGVlX3NhdmVfcmVnc190aHVuaywgbW9yZSB1bm5lY2Vzc2FyeSByZWdp
c3RlcnMgbWlnaHQgYmUgc2F2ZS9yZXNvdHJlZCBpbiBwdiBjYXNlLgp0aGF0IHdpbGwgaW50cm9k
dWNlIGEgbGl0dGxlIG92ZXJoZWFkLgoKYnV0IEkgdGhpbmsgSSBhbSBva2F5IHdpdGggeW91ciBp
ZGVhLiBJIGNhbiBtYWtlIGFub3RoZXIgcGF0Y2ggYmFzZWQgb24gdGhpcyBwYXRjaHNldCB3aXRo
IHlvdXIgc3VnZ2VzdGVkLWJ5LgoKdGhhbmtzCnhpbmh1aQoKPiBBbHNvLCBpdCBnZW5lcmF0ZXMg
bW9yZSBjb2RlLgo+Cj4gUGFyYXZpcnQgbXVjayBzaG91bGQgc3RyaXZlIHRvIGJlIGFzIGNoZWFw
IGFzIHBvc3NpYmxlIHdoZW4gcmFuIG9uCj4gbmF0aXZlIGhhcmR3YXJlLgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
