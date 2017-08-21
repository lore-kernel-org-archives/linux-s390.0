From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RFC v3 3/9] KVM: remember position in kvm->vcpus array
Date: Mon, 21 Aug 2017 22:35:24 +0200
Message-ID: <20170821203530.9266-4-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821203530.9266-1-rkrcmar@redhat.com>
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
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Christoffer Dall <cdall@linaro.org>, James Hogan <james.hogan@imgtec.com>, David Hildenbrand <david@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Cornelia Huck <cohuck@redhat.com>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

U2lnbmVkLW9mZi1ieTogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+Ci0tLQog
aW5jbHVkZS9saW51eC9rdm1faG9zdC5oIHwgMTEgKysrLS0tLS0tLS0KIHZpcnQva3ZtL2t2bV9t
YWluLmMgICAgICB8ICA1ICsrKystCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmggYi9p
bmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKaW5kZXggNjg4MjUzOGVkYTMyLi5hOGZmOTU2NjE2ZDIg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4
L2t2bV9ob3N0LmgKQEAgLTIyMCw3ICsyMjAsOCBAQCBzdHJ1Y3Qga3ZtX3ZjcHUgewogCXN0cnVj
dCBwcmVlbXB0X25vdGlmaWVyIHByZWVtcHRfbm90aWZpZXI7CiAjZW5kaWYKIAlpbnQgY3B1Owot
CWludCB2Y3B1X2lkOworCWludCB2Y3B1X2lkOyAvKiBpZCBnaXZlbiBieSB1c2Vyc3BhY2UgYXQg
Y3JlYXRpb24gKi8KKwlpbnQgdmNwdXNfaWR4OyAvKiBpbmRleCBpbiBrdm0tPnZjcHVzIGFycmF5
ICovCiAJaW50IHNyY3VfaWR4OwogCWludCBtb2RlOwogCXVuc2lnbmVkIGxvbmcgcmVxdWVzdHM7
CkBAIC01MTYsMTMgKzUxNyw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGt2bV92Y3B1ICprdm1f
Z2V0X3ZjcHVfYnlfaWQoc3RydWN0IGt2bSAqa3ZtLCBpbnQgaWQpCiAKIHN0YXRpYyBpbmxpbmUg
aW50IGt2bV92Y3B1X2dldF9pZHgoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogewotCXN0cnVjdCBr
dm1fdmNwdSAqdG1wOwotCWludCBpZHg7Ci0KLQlrdm1fZm9yX2VhY2hfdmNwdShpZHgsIHRtcCwg
dmNwdS0+a3ZtKQotCQlpZiAodG1wID09IHZjcHUpCi0JCQlyZXR1cm4gaWR4OwotCUJVRygpOwor
CXJldHVybiB2Y3B1LT52Y3B1c19pZHg7CiB9CiAKICNkZWZpbmUga3ZtX2Zvcl9lYWNoX21lbXNs
b3QobWVtc2xvdCwgc2xvdHMpCVwKZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2t2bV9tYWluLmMgYi92
aXJ0L2t2bS9rdm1fbWFpbi5jCmluZGV4IGUxN2M0MGQ5ODZmMy4uY2FmODMyM2Y3ZGY3IDEwMDY0
NAotLS0gYS92aXJ0L2t2bS9rdm1fbWFpbi5jCisrKyBiL3ZpcnQva3ZtL2t2bV9tYWluLmMKQEAg
LTI0OTgsNyArMjQ5OCwxMCBAQCBzdGF0aWMgaW50IGt2bV92bV9pb2N0bF9jcmVhdGVfdmNwdShz
dHJ1Y3Qga3ZtICprdm0sIHUzMiBpZCkKIAkJZ290byB1bmxvY2tfdmNwdV9kZXN0cm95OwogCX0K
IAotCUJVR19PTihrdm0tPnZjcHVzW2F0b21pY19yZWFkKCZrdm0tPm9ubGluZV92Y3B1cyldKTsK
Kwl2Y3B1LT52Y3B1c19pZHggPSBhdG9taWNfcmVhZCgma3ZtLT5vbmxpbmVfdmNwdXMpOworCisJ
QlVHX09OKGt2bS0+dmNwdXNbdmNwdS0+dmNwdXNfaWR4XSk7CisKIAogCS8qIE5vdyBpdCdzIGFs
bCBzZXQgdXAsIGxldCB1c2Vyc3BhY2UgcmVhY2ggaXQgKi8KIAlrdm1fZ2V0X2t2bShrdm0pOwot
LSAKMi4xMy4zCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
