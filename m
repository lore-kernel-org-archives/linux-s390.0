From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Date: Fri, 30 Sep 2016 12:00:12 +0800
Message-ID: <15710298-7a7b-5c01-6cf6-25c7dc0bcbdc@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160929101040.GV5016@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160929101040.GV5016@twins.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, jgross@suse.com, kvm@vger.kernel.org, xen-devel-request@lists.xenproject.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

CgrlnKggMjAxNi85LzI5IDE4OjEwLCBQZXRlciBaaWpsc3RyYSDlhpnpgZM6Cj4gT24gVGh1LCBK
dWwgMjEsIDIwMTYgYXQgMDc6NDU6MTBBTSAtMDQwMCwgUGFuIFhpbmh1aSB3cm90ZToKPj4gY2hh
bmdlIGZyb20gdjI6Cj4+IAlubyBjb2RlIGNoYW5nZSwgZml4IHR5cG9zLCB1cGRhdGUgc29tZSBj
b21tZW50cwo+Pgo+PiBjaGFuZ2UgZnJvbSB2MToKPj4gCWEgc2ltcGxpZXIgZGVmaW5pdGlvbiBv
ZiBkZWZhdWx0IHZjcHVfaXNfcHJlZW1wdGVkCj4+IAlza2lwIG1haGNpbmUgdHlwZSBjaGVjayBv
biBwcGMsIGFuZCBhZGQgY29uZmlnLiByZW1vdmUgZGVkaWNhdGVkIG1hY3JvLgo+PiAJYWRkIG9u
ZSBwYXRjaCB0byBkcm9wIG92ZXJsb2FkIG9mIHJ3c2VtX3NwaW5fb25fb3duZXIgYW5kIG11dGV4
X3NwaW5fb25fb3duZXIuCj4+IAlhZGQgbW9yZSBjb21tZW50cwo+PiAJdGhhbmtzIGJvcXVuIGFu
ZCBQZXRlcidzIHN1Z2dlc3Rpb24uCj4+Cj4+IFRoaXMgcGF0Y2ggc2V0IGFpbXMgdG8gZml4IGxv
Y2sgaG9sZGVyIHByZWVtcHRpb24gaXNzdWVzLgo+Cj4gU28gSSByZWFsbHkgbGlrZSB0aGUgY29u
Y2VwdCwgYnV0IEkgd291bGQgYWxzbyByZWFsbHkgbGlrZSB0byBzZWUKPiBzdXBwb3J0IGZvciBt
b3JlIGh5cGVydmlzb3JzIGluY2x1ZGVkIGJlZm9yZSB3ZSBjYW4gbW92ZSBmb3J3YXJkIHdpdGgK
PiB0aGlzLgo+Cj4gUGxlYXNlIGNvbnNpZGVyIHMzOTAgYW5kICh4ODYvYXJtKSBLVk0uIE9uY2Ug
d2UgaGF2ZSBhIGZldywgbW9yZSBjYW4KPiBmb2xsb3cgbGF0ZXIsIGJ1dCBJIHRoaW5rIGl0cyBp
bXBvcnRhbnQgdG8gbm90IG9ubHkgaGF2ZSBQUEMgc3VwcG9ydCBmb3IKPiB0aGlzLgo+CmhpLCBQ
ZXRlcgoJcmlnaHQsIHdlIG5lZWQgY29uc2lkZXIgbW9yZSBhcmNoZXMuCkkgd2lsbCB0cnkgdG8g
d29yayBvdXQgYSBSRkMgcGF0Y2ggb24geDg2IGFueXdheS4gVGhlcmUgYXJlIGFscmVhZHkgc29t
ZSBkaXNjdXNzaW9ucyBvZiB0aGUgc29sdXRpb24gb24geDg2IDopCgp0aGFua3MKeGluaHVpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
