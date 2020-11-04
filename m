Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbgKDCmu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 21:42:50 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9577C061A4D
        for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2020 18:42:48 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id i19so16580707ejx.9
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2020 18:42:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
 <20201009013630.6777-1-rentianyue@tj.kylinos.cn> <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
 <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
 <yt9dh7q64m8a.fsf@linux.ibm.com> <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
 <yt9dpn4u9scs.fsf@linux.ibm.com>
In-Reply-To: <yt9dpn4u9scs.fsf@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2020 21:42:35 -0500
Message-ID: <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
Content-Type: multipart/mixed; boundary="00000000000049141305b33eef93"
List-ID: <linux-s390.vger.kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: rentianyue@tj.kylinos.cn, Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn, selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>, linux-s390@vger.kernel.org, hca@linux.ibm.com, borntraeger@de.ibm.com

--00000000000049141305b33eef93
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 3, 2020 at 2:02 PM Sven Schnelle <svens@linux.ibm.com> wrote:
> Thanks for the patch. Unfortunately it doesn't seem to change anything
> for me. I can take a look into this tomorrow, but i don't know much
> about the internals of selinux, so i'm not sure whether i'm of much help.

I'm sorry that patch didn't work out.  I just spent some more time
looking at the code+patch and the only other thing that I can see is
that if we mark the isec invalid, we don't bother setting the
isec->sid value to whatever default we may have already found.  In a
perfect world this shouldn't matter, but if for whatever reason the
kernel can't revalidate the inode's label when it tries later it will
fallback to that default isec->sid.

I'm sorry to ask this again, but would you be able to test the attached patch?

-- 
paul moore
www.paul-moore.com

--00000000000049141305b33eef93
Content-Type: text/x-patch; charset="US-ASCII"; name="01-selinux-inode_dentry_init_fix.patch"
Content-Disposition: attachment; 
	filename="01-selinux-inode_dentry_init_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kh2spx770>
X-Attachment-Id: f_kh2spx770

c2VsaW51eDogZml4IGlub2RlX2RvaW5pdF93aXRoX2RlbnRyeSgpIGVycm9yIGNhc2UgbG9ja2lu
ZwoKRnJvbTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KClhYWCAtIHRlc3Rpbmcg
b25seSBwYXRjaCwgd29yayBpbiBwcm9ncmVzcwoKRml4ZXM6IDgzMzcwYjMxYTkxNSAoInNlbGlu
dXg6IGZpeCBlcnJvciBpbml0aWFsaXphdGlvbiBpbiBpbm9kZV9kb2luaXRfd2l0aF9kZW50cnko
KSIpClJlcG9ydGVkLWJ5OiBTdmVuIFNjaG5lbGxlIDxzdmVuc0BsaW51eC5pYm0uY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPgotLS0KIHNlY3VyaXR5
L3NlbGludXgvaG9va3MuYyB8ICAgMzEgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3Mu
YwppbmRleCAxNThmYzQ3ZDg2MjAuLmM0NjMxMjcxMGU3MyAxMDA2NDQKLS0tIGEvc2VjdXJpdHkv
c2VsaW51eC9ob29rcy5jCisrKyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwpAQCAtMTQ1MSwx
MyArMTQ1MSw3IEBAIHN0YXRpYyBpbnQgaW5vZGVfZG9pbml0X3dpdGhfZGVudHJ5KHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHN0cnVjdCBkZW50cnkgKm9wdF9kZW50CiAJCQkgKiBpbm9kZV9kb2luaXQg
d2l0aCBhIGRlbnRyeSwgYmVmb3JlIHRoZXNlIGlub2RlcyBjb3VsZAogCQkJICogYmUgdXNlZCBh
Z2FpbiBieSB1c2Vyc3BhY2UuCiAJCQkgKi8KLQkJCWlzZWMtPmluaXRpYWxpemVkID0gTEFCRUxf
SU5WQUxJRDsKLQkJCS8qCi0JCQkgKiBUaGVyZSBpcyBub3RoaW5nIHVzZWZ1bCB0byBqdW1wIHRv
IHRoZSAib3V0IgotCQkJICogbGFiZWwsIGV4Y2VwdCBhIG5lZWRsZXNzIHNwaW4gbG9jay91bmxv
Y2sKLQkJCSAqIGN5Y2xlLgotCQkJICovCi0JCQlyZXR1cm4gMDsKKwkJCWdvdG8gb3V0X2ludmFs
aWQ7CiAJCX0KIAogCQlyYyA9IGlub2RlX2RvaW5pdF91c2VfeGF0dHIoaW5vZGUsIGRlbnRyeSwg
c2JzZWMtPmRlZl9zaWQsCkBAIC0xNTEzLDE1ICsxNTA3LDggQEAgc3RhdGljIGludCBpbm9kZV9k
b2luaXRfd2l0aF9kZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRlbnRyeSAqb3B0
X2RlbnQKIAkJCSAqIGlub2RlX2RvaW5pdCgpIHdpdGggYSBkZW50cnksIGJlZm9yZSB0aGVzZSBp
bm9kZXMKIAkJCSAqIGNvdWxkIGJlIHVzZWQgYWdhaW4gYnkgdXNlcnNwYWNlLgogCQkJICovCi0J
CQlpZiAoIWRlbnRyeSkgewotCQkJCWlzZWMtPmluaXRpYWxpemVkID0gTEFCRUxfSU5WQUxJRDsK
LQkJCQkvKgotCQkJCSAqIFRoZXJlIGlzIG5vdGhpbmcgdXNlZnVsIHRvIGp1bXAgdG8gdGhlICJv
dXQiCi0JCQkJICogbGFiZWwsIGV4Y2VwdCBhIG5lZWRsZXNzIHNwaW4gbG9jay91bmxvY2sKLQkJ
CQkgKiBjeWNsZS4KLQkJCQkgKi8KLQkJCQlyZXR1cm4gMDsKLQkJCX0KKwkJCWlmICghZGVudHJ5
KQorCQkJCWdvdG8gb3V0X2ludmFsaWQ7CiAJCQlyYyA9IHNlbGludXhfZ2VuZnNfZ2V0X3NpZChk
ZW50cnksIHNjbGFzcywKIAkJCQkJCSAgIHNic2VjLT5mbGFncywgJnNpZCk7CiAJCQlpZiAocmMp
IHsKQEAgLTE1NDYsMTEgKzE1MzMsMTAgQEAgc3RhdGljIGludCBpbm9kZV9kb2luaXRfd2l0aF9k
ZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRlbnRyeSAqb3B0X2RlbnQKIG91dDoK
IAlzcGluX2xvY2soJmlzZWMtPmxvY2spOwogCWlmIChpc2VjLT5pbml0aWFsaXplZCA9PSBMQUJF
TF9QRU5ESU5HKSB7Ci0JCWlmICghc2lkIHx8IHJjKSB7CisJCWlmIChyYykgewogCQkJaXNlYy0+
aW5pdGlhbGl6ZWQgPSBMQUJFTF9JTlZBTElEOwogCQkJZ290byBvdXRfdW5sb2NrOwogCQl9Ci0K
IAkJaXNlYy0+aW5pdGlhbGl6ZWQgPSBMQUJFTF9JTklUSUFMSVpFRDsKIAkJaXNlYy0+c2lkID0g
c2lkOwogCX0KQEAgLTE1NTgsNiArMTU0NCwxNSBAQCBzdGF0aWMgaW50IGlub2RlX2RvaW5pdF93
aXRoX2RlbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZGVudHJ5ICpvcHRfZGVudAog
b3V0X3VubG9jazoKIAlzcGluX3VubG9jaygmaXNlYy0+bG9jayk7CiAJcmV0dXJuIHJjOworCitv
dXRfaW52YWxpZDoKKwlzcGluX2xvY2soJmlzZWMtPmxvY2spOworCWlmIChpc2VjLT5pbml0aWFs
aXplZCA9PSBMQUJFTF9QRU5ESU5HKSB7CisJCWlzZWMtPmluaXRpYWxpemVkID0gTEFCRUxfSU5W
QUxJRDsKKwkJaXNlYy0+c2lkID0gc2lkOworCX0KKwlzcGluX3VubG9jaygmaXNlYy0+bG9jayk7
CisJcmV0dXJuIDA7CiB9CiAKIC8qIENvbnZlcnQgYSBMaW51eCBzaWduYWwgdG8gYW4gYWNjZXNz
IHZlY3Rvci4gKi8K
--00000000000049141305b33eef93--
