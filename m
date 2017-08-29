From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
Date: Tue, 29 Aug 2017 13:23:42 +0200
Message-ID: <20170829132342.1ef25500.cohuck@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-2-rkrcmar@redhat.com>
 <67a8b09c-3e7a-943d-8684-f9ad6e70514b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <67a8b09c-3e7a-943d-8684-f9ad6e70514b@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, Christoffer Dall <cdall@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.com>, Paul Mackerras <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

T24gVHVlLCAyMiBBdWcgMjAxNyAxMzozMToyNyArMDIwMApEYXZpZCBIaWxkZW5icmFuZCA8ZGF2
aWRAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+IE9uIDIxLjA4LjIwMTcgMjI6MzUsIFJhZGltIEtyxI1t
w6HFmSB3cm90ZToKPiA+IFdlIGNhbiBhZGQgYSB2YXJpYWJsZSBpbnN0ZWFkIG9mIHNjYW5uaW5n
IGFsbCBvbmxpbmUgVkNQVXMgdG8ga25vdyBob3cKPiA+IG1hbnkgYXJlIHN0YXJ0ZWQuICBXZSBj
YW4ndCB0cml2aWFsbHkgdGVsbCB3aGljaCBWQ1BVIGlzIHRoZSBsYXN0IG9uZSwKPiA+IHRob3Vn
aC4gIAo+IAo+IFlvdSBjb3VsZCBrZWVwIHRoZSBzdGFydGVkIHZjcHVzIGluIGEgbGlzdC4gVGhl
biB5b3UgbWlnaHQgZHJvcCB1bnNpZ25lZAo+IHN0YXJ0ZWRfdmNwdXM7Cj4gCj4gTm8gc3RhcnRl
ZCB2Y3B1czogU3RhcnQgcG9pbnRlciBOVUxMCj4gU2luZ2xlIHN0YXJ0ZWQgdmNwdTogT25seSBv
bmUgZWxlbWVudCBpbiB0aGUgbGlzdCAoZWFzeSB0byBjaGVjaykKPiA+IDEgc3RhcnRlZCB2Y3B1
czogTW9yZSB0aGFuIG9uZSBlbGVtZW50IGludCBoZSBsaXN0IChlYXN5IHRvIGNoZWNrKSAgCgpJ
J20gbm90IHN1cmUgdGhlIGFkZGVkIGNvbXBsaWNhdGlvbiBvZiBrZWVwaW5nIGEgbGlzdCBidXlz
IHVzIG11Y2gKaGVyZTogV2Ugb25seSBoYXZlIHRoZSAibG9vayBmb3IgdGhlIGxhc3QgdmNwdSBu
b3Qgc3RvcHBlZCIgb3BlcmF0aW9uCmZvciB0aGUgMi0+MSB0cmFuc2l0aW9uLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
