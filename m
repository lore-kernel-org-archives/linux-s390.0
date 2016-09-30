From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
Date: Fri, 30 Sep 2016 13:03:34 +0800
Message-ID: <496ba299-1f1d-e98b-7827-f861eeea5558@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160929101040.GV5016@twins.programming.kicks-ass.net>
	<166f3bad-f700-4624-6c1c-996f90ad609c@de.ibm.com>
	<20160929103133.GW5016@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160929103133.GW5016@twins.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

CgrlnKggMjAxNi85LzI5IDE4OjMxLCBQZXRlciBaaWpsc3RyYSDlhpnpgZM6Cj4gT24gVGh1LCBT
ZXAgMjksIDIwMTYgYXQgMTI6MjM6MTlQTSArMDIwMCwgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdy
b3RlOgo+PiBPbiAwOS8yOS8yMDE2IDEyOjEwIFBNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPj4+
IE9uIFRodSwgSnVsIDIxLCAyMDE2IGF0IDA3OjQ1OjEwQU0gLTA0MDAsIFBhbiBYaW5odWkgd3Jv
dGU6Cj4+Pj4gY2hhbmdlIGZyb20gdjI6Cj4+Pj4gCW5vIGNvZGUgY2hhbmdlLCBmaXggdHlwb3Ms
IHVwZGF0ZSBzb21lIGNvbW1lbnRzCj4+Pj4KPj4+PiBjaGFuZ2UgZnJvbSB2MToKPj4+PiAJYSBz
aW1wbGllciBkZWZpbml0aW9uIG9mIGRlZmF1bHQgdmNwdV9pc19wcmVlbXB0ZWQKPj4+PiAJc2tp
cCBtYWhjaW5lIHR5cGUgY2hlY2sgb24gcHBjLCBhbmQgYWRkIGNvbmZpZy4gcmVtb3ZlIGRlZGlj
YXRlZCBtYWNyby4KPj4+PiAJYWRkIG9uZSBwYXRjaCB0byBkcm9wIG92ZXJsb2FkIG9mIHJ3c2Vt
X3NwaW5fb25fb3duZXIgYW5kIG11dGV4X3NwaW5fb25fb3duZXIuCj4+Pj4gCWFkZCBtb3JlIGNv
bW1lbnRzCj4+Pj4gCXRoYW5rcyBib3F1biBhbmQgUGV0ZXIncyBzdWdnZXN0aW9uLgo+Pj4+Cj4+
Pj4gVGhpcyBwYXRjaCBzZXQgYWltcyB0byBmaXggbG9jayBob2xkZXIgcHJlZW1wdGlvbiBpc3N1
ZXMuCj4+Pgo+Pj4gU28gSSByZWFsbHkgbGlrZSB0aGUgY29uY2VwdCwgYnV0IEkgd291bGQgYWxz
byByZWFsbHkgbGlrZSB0byBzZWUKPj4+IHN1cHBvcnQgZm9yIG1vcmUgaHlwZXJ2aXNvcnMgaW5j
bHVkZWQgYmVmb3JlIHdlIGNhbiBtb3ZlIGZvcndhcmQgd2l0aAo+Pj4gdGhpcy4KPj4+Cj4+PiBQ
bGVhc2UgY29uc2lkZXIgczM5MCBhbmQgKHg4Ni9hcm0pIEtWTS4gT25jZSB3ZSBoYXZlIGEgZmV3
LCBtb3JlIGNhbgo+Pj4gZm9sbG93IGxhdGVyLCBidXQgSSB0aGluayBpdHMgaW1wb3J0YW50IHRv
IG5vdCBvbmx5IGhhdmUgUFBDIHN1cHBvcnQgZm9yCj4+PiB0aGlzLgo+Pgo+PiBBY3R1YWxseSB0
aGUgczM5MCBwcmVlbXRlZCBjaGVjayB2aWEgc2lncCBzZW5zZSBydW5uaW5nICBpcyBhdmFpbGFi
bGUgZm9yCj4+IGFsbCBoeXBlcnZpc29ycyAoei9WTSwgTFBBUiBhbmQgS1ZNKSB3aGljaCBpbXBs
aWVzIGV2ZXJ5d2hlcmUgYXMgeW91IGNhbiBubwo+PiBsb25nZXIgYnV5IHMzOTAgc3lzdGVtcyB3
aXRob3V0IExQQVIuCj4+Cj4+IEFzIEhlaWtvIGFscmVhZHkgcG9pbnRlZCBvdXQgd2UgY291bGQg
c2ltcGx5IHVzZSBhIHNtYWxsIGlubGluZSBmdW5jdGlvbgo+PiB0aGF0IGNhbGxzIGNwdV9pc19w
cmVlbXB0ZWQgZnJvbSBhcmNoL3MzOTAvbGliL3NwaW5sb2NrIChvciBzbXBfdmNwdV9zY2hlZHVs
ZWQgZnJvbSBzbXAuYykKPgo+IFN1cmUsIGFuZCBJIGhhZCB2YWd1ZSBtZW1vcmllcyBvZiBIZWlr
bydzIGVtYWlsLiBUaGlzIHBhdGNoIHNldCBob3dldmVyCj4gY29tcGxldGVseSBmYWlscyB0byBk
byB0aGF0IHRyaXZpYWwgaG9va2luZyB1cC4KPgoKc29ycnkgZm9yIHRoYXQuCkkgd2lsbCB0cnkg
dG8gd29yayBpdCBvdXQgb24geDg2LgoKSGksIFdpbGwKCUkgYXBwcmVjaWF0ZSB0aGF0IGlmIHlv
dSBvciBzb21lIG90aGVyIGFybSBndXlzIGNvdWxkIGhlbHAgb24gaXQuIDopCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
