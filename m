From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 10/11] x86, xen: support vcpu preempted check
Date: Wed,  2 Nov 2016 05:08:37 -0400
Message-ID: <1478077718-37424-11-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: kernellwp@gmail.com, jgross@suse.com, dave@stgolabs.net, David.Laight@ACULAB.COM, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, bsingharora@gmail.com, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, borntraeger@de.ibm.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com
List-ID: <linux-s390.vger.kernel.org>

RnJvbTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgoKU3VwcG9ydCB0aGUgdmNwdV9p
c19wcmVlbXB0ZWQoKSBmdW5jdGlvbmFsaXR5IHVuZGVyIFhlbi4gVGhpcyB3aWxsCmVuaGFuY2Ug
bG9jayBwZXJmb3JtYW5jZSBvbiBvdmVyY29tbWl0dGVkIGhvc3RzIChtb3JlIHJ1bm5hYmxlIHZj
cHVzCnRoYW4gcGh5c2ljYWwgY3B1cyBpbiB0aGUgc3lzdGVtKSBhcyBkb2luZyBidXN5IHdhaXRz
IGZvciBwcmVlbXB0ZWQKdmNwdXMgd2lsbCBodXJ0IHN5c3RlbSBwZXJmb3JtYW5jZSBmYXIgd29y
c2UgdGhhbiBlYXJseSB5aWVsZGluZy4KCkEgcXVpY2sgdGVzdCAoNCB2Y3B1cyBvbiAxIHBoeXNp
Y2FsIGNwdSBkb2luZyBhIHBhcmFsbGVsIGJ1aWxkIGpvYgp3aXRoICJtYWtlIC1qIDgiKSByZWR1
Y2VkIHN5c3RlbSB0aW1lIGJ5IGFib3V0IDUlIHdpdGggdGhpcyBwYXRjaC4KClNpZ25lZC1vZmYt
Ynk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTogUGFuIFhp
bmh1aSA8eGluaHVpLnBhbkBsaW51eC52bmV0LmlibS5jb20+Ci0tLQogYXJjaC94ODYveGVuL3Nw
aW5sb2NrLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9zcGlubG9jay5jIGIvYXJjaC94ODYv
eGVuL3NwaW5sb2NrLmMKaW5kZXggM2Q2ZTAwNi4uNzQ3NTZiYiAxMDA2NDQKLS0tIGEvYXJjaC94
ODYveGVuL3NwaW5sb2NrLmMKKysrIGIvYXJjaC94ODYveGVuL3NwaW5sb2NrLmMKQEAgLTExNCw3
ICsxMTQsNiBAQCB2b2lkIHhlbl91bmluaXRfbG9ja19jcHUoaW50IGNwdSkKIAlwZXJfY3B1KGly
cV9uYW1lLCBjcHUpID0gTlVMTDsKIH0KIAotCiAvKgogICogT3VyIGluaXQgb2YgUFYgc3Bpbmxv
Y2tzIGlzIHNwbGl0IGluIHR3byBpbml0IGZ1bmN0aW9ucyBkdWUgdG8gdXMKICAqIHVzaW5nIHBh
cmF2aXJ0IHBhdGNoaW5nIGFuZCBqdW1wIGxhYmVscyBwYXRjaGluZyBhbmQgaGF2aW5nIHRvIGRv
CkBAIC0xMzcsNiArMTM2LDggQEAgdm9pZCBfX2luaXQgeGVuX2luaXRfc3BpbmxvY2tzKHZvaWQp
CiAJcHZfbG9ja19vcHMucXVldWVkX3NwaW5fdW5sb2NrID0gUFZfQ0FMTEVFX1NBVkUoX19wdl9x
dWV1ZWRfc3Bpbl91bmxvY2spOwogCXB2X2xvY2tfb3BzLndhaXQgPSB4ZW5fcWxvY2tfd2FpdDsK
IAlwdl9sb2NrX29wcy5raWNrID0geGVuX3Fsb2NrX2tpY2s7CisKKwlwdl9sb2NrX29wcy52Y3B1
X2lzX3ByZWVtcHRlZCA9IHhlbl92Y3B1X3N0b2xlbjsKIH0KIAogLyoKLS0gCjIuNC4xMQoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBt
YWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3Jn
L3hlbi1kZXZlbAo=
