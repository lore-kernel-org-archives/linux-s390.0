Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF0C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 20:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiCHUE1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350096AbiCHUE1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 15:04:27 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA33D1F6
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 12:03:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n19so13114218lfh.8
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czsRGOkOn3Lgpr63tuiW4SCDSW01owb7EuPhkTzECmM=;
        b=bOcSUSaffQIuHF2CSU04hVbpPCejg/SdphJ6c1+LuWKBJjlLZbbCI4HeWDmKQqotw6
         Z+FhPUs0dHXmbekhhf5T8yXt+lsbxU+tYj01K3m3MHIYZXN4QXKRxMhMJnW0d8+S2sd3
         3/4ljensKECXT+zaZ2BHQJbn0bZRqLGy0/n0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czsRGOkOn3Lgpr63tuiW4SCDSW01owb7EuPhkTzECmM=;
        b=KTeJ4hJPmp+AMQC58FMsRX5rs8tQVjleLqOSvMOuZBZSCkY5ql4SGaYAo4eCW89NNm
         ZSEHw2dzO6BWb2DLa1BeByK1U78jlMn1ZRIpkrf5ewANJwPPRNAjn20lnzGM65b7lUnP
         zRp6ia+8dhpalvIWb4w0lkUpIg8UtgD2xhIippGTCbTWaSrepV1aku47ZP+siSwM1WHI
         S5q4xZtYItSbux2FoRsBdAPylxxXFmr6m8LAz9+EllljTgKVCDpSVr5VIKFE4bfQj4n6
         Qtp6mkXKbUQ+nTr71TYJ8MOv0fzlJFXbP0wUIqAeZ0AFdliSOlmoUZ1F4isTIJ+6/tM5
         3U+Q==
X-Gm-Message-State: AOAM533BURKUdAUkHaDq9sjMGmutgvqJTfAVu1me4MQwQzZX4I4bdmSp
        CTXhtylx5Mvr5KsYBnUPlkeil87Gf7kyoV+Atn0=
X-Google-Smtp-Source: ABdhPJzGBRHbLe/v/xwUAqS7DqCtpA3pKX0HJstV/Pb8kmtSObcAzLLwaiQCx8t/ZZnL6xZFwAu22Q==
X-Received: by 2002:a05:6512:3248:b0:448:3231:2800 with SMTP id c8-20020a056512324800b0044832312800mr6408684lfr.24.1646769807782;
        Tue, 08 Mar 2022 12:03:27 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a19-20020a2e88d3000000b00246585ccd51sm4059459ljk.14.2022.03.08.12.03.25
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:03:25 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id z11so18843537lfh.13
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 12:03:25 -0800 (PST)
X-Received: by 2002:ac2:44a4:0:b0:445:8fc5:a12a with SMTP id
 c4-20020ac244a4000000b004458fc5a12amr11949016lfm.27.1646769804575; Tue, 08
 Mar 2022 12:03:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com> <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 12:03:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
Message-ID: <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003abc5505d9ba794e"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--0000000000003abc5505d9ba794e
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 11:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think the fix for this all might be something like the attached
> (TOTALLY UNTESTED)!

Still entirely untested, but I wrote a commit message for it in the
hopes that this actually works and Andreas can verify that it fixes
the issue.

Same exact patch, it's just now in my local experimental tree as a commit.

                  Linus

--0000000000003abc5505d9ba794e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-gup-make-fault_in_safe_writeable-use-fixup_user_f.patch"
Content-Disposition: attachment; 
	filename="0001-mm-gup-make-fault_in_safe_writeable-use-fixup_user_f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0ik6w7o0>
X-Attachment-Id: f_l0ik6w7o0

RnJvbSBkOGMyZTBhODEyNzRkNjdlZGZmZjM3NjljNGMzN2UzNjRiYThkNmY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgOCBNYXIgMjAyMiAxMTo1NTo0OCAtMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tOiBndXA6IG1ha2UgZmF1bHRfaW5fc2FmZV93cml0ZWFibGUoKSB1c2UKIGZpeHVw
X3VzZXJfZmF1bHQoKQoKSW5zdGVkYWQgb2YgdXNpbmcgR1VQLCBtYWtlIGZhdWx0X2luX3NhZmVf
d3JpdGVhYmxlKCkgYWN0dWFsbHkgZm9yY2UgYQonaGFuZGxlX21tX2ZhdWx0KCknIHVzaW5nIHRo
ZSBzYW1lIGZpeHVwX3VzZXJfZmF1bHQoKSBtYWNoaW5lcnkgdGhhdApmdXRleGVzIGFscmVhZHkg
dXNlLgoKVXNpbmcgdGhlIEdVUCBtYWNoaW5lcnkgbWVhbnQgdGhhdCBmYXVsdF9pbl9zYWZlX3dy
aXRlYWJsZSgpIGRpZCBub3QgZG8KZXZlcnl0aGluZyB0aGF0IGEgcmVhbCBmYXVsdCB3b3VsZCBk
bywgcmFuZ2luZyBmcm9tIG5vdCBhdXRvLWV4cGFuZGluZwp0aGUgc3RhY2sgc2VnbWVudCwgdG8g
bm90IHVwZGF0aW5nIGFjY2Vzc2VkIG9yIGRpcnR5IGZsYWdzIGluIHRoZSBwYWdlCnRhYmxlcyAo
R1VQIHNldHMgdGhvc2UgZmxhZ3Mgb24gdGhlIHBhZ2VzIHRoZW1zZWx2ZXMpLgoKVGhlIGxhdHRl
ciBjYXVzZXMgcHJvYmxlbXMgb24gYXJjaGl0ZWN0dXJlcyAobGlrZSBzMzkwKSB0aGF0IGRvIGFj
Y2Vzc2VkCmJpdCBoYW5kbGluZyBpbiBzb2Z0d2FyZSwgd2hpY2ggbWVhbnQgdGhhdCBmYXVsdF9p
bl9zYWZlX3dyaXRlYWJsZSgpCmRpZG4ndCBhY3R1YWxseSBkbyBhbGwgdGhlIGZhdWx0IGhhbmRs
aW5nIGl0IG5lZWRlZCB0by4KClJlcG9ydGVkLWJ5OiBBbmRyZWFzIEdydWVuYmFjaGVyIDxhZ3J1
ZW5iYUByZWRoYXQuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FIYzZG
VTVuUCtuemlOR0cwSkFGMUZVeC1HVjdrS0Z2TTdhWnVVX1hEMl8xdjR2bnZnQG1haWwuZ21haWwu
Y29tLwpDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYt
Ynk6IGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIG1t
L2d1cC5jIHwgNDAgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL21tL2d1cC5jIGIvbW0vZ3VwLmMKaW5kZXggYTlkNGQ3MjRhZWY3Li45ZTA4NWU3YjljMjgg
MTAwNjQ0Ci0tLSBhL21tL2d1cC5jCisrKyBiL21tL2d1cC5jCkBAIC0xNzQ1LDQ0ICsxNzQ1LDI4
IEBAIEVYUE9SVF9TWU1CT0woZmF1bHRfaW5fd3JpdGVhYmxlKTsKIHNpemVfdCBmYXVsdF9pbl9z
YWZlX3dyaXRlYWJsZShjb25zdCBjaGFyIF9fdXNlciAqdWFkZHIsIHNpemVfdCBzaXplKQogewog
CXVuc2lnbmVkIGxvbmcgc3RhcnQgPSAodW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHVhZGRy
KTsKLQl1bnNpZ25lZCBsb25nIGVuZCwgbnN0YXJ0LCBuZW5kOworCXVuc2lnbmVkIGxvbmcgZW5k
LCBuc3RhcnQ7CiAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsKLQlzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IE5VTEw7Ci0JaW50IGxvY2tlZCA9IDA7CisJY29uc3QgdW5z
aWduZWQgaW50IGZhdWx0X2ZsYWdzID0gRkFVTFRfRkxBR19XUklURSB8IEZBVUxUX0ZMQUdfS0lM
TEFCTEU7CisJY29uc3Qgc2l6ZV90IG1heF9zaXplID0gNCAqIFBBR0VfU0laRTsKIAogCW5zdGFy
dCA9IHN0YXJ0ICYgUEFHRV9NQVNLOwotCWVuZCA9IFBBR0VfQUxJR04oc3RhcnQgKyBzaXplKTsK
KwllbmQgPSBQQUdFX0FMSUdOKHN0YXJ0ICsgbWluKHNpemUsIG1heF9zaXplKSk7CiAJaWYgKGVu
ZCA8IG5zdGFydCkKIAkJZW5kID0gMDsKLQlmb3IgKDsgbnN0YXJ0ICE9IGVuZDsgbnN0YXJ0ID0g
bmVuZCkgewotCQl1bnNpZ25lZCBsb25nIG5yX3BhZ2VzOwotCQlsb25nIHJldDsKIAotCQlpZiAo
IWxvY2tlZCkgewotCQkJbG9ja2VkID0gMTsKLQkJCW1tYXBfcmVhZF9sb2NrKG1tKTsKLQkJCXZt
YSA9IGZpbmRfdm1hKG1tLCBuc3RhcnQpOwotCQl9IGVsc2UgaWYgKG5zdGFydCA+PSB2bWEtPnZt
X2VuZCkKLQkJCXZtYSA9IHZtYS0+dm1fbmV4dDsKLQkJaWYgKCF2bWEgfHwgdm1hLT52bV9zdGFy
dCA+PSBlbmQpCi0JCQlicmVhazsKLQkJbmVuZCA9IGVuZCA/IG1pbihlbmQsIHZtYS0+dm1fZW5k
KSA6IHZtYS0+dm1fZW5kOwotCQlpZiAodm1hLT52bV9mbGFncyAmIChWTV9JTyB8IFZNX1BGTk1B
UCkpCi0JCQljb250aW51ZTsKLQkJaWYgKG5zdGFydCA8IHZtYS0+dm1fc3RhcnQpCi0JCQluc3Rh
cnQgPSB2bWEtPnZtX3N0YXJ0OwotCQlucl9wYWdlcyA9IChuZW5kIC0gbnN0YXJ0KSAvIFBBR0Vf
U0laRTsKLQkJcmV0ID0gX19nZXRfdXNlcl9wYWdlc19sb2NrZWQobW0sIG5zdGFydCwgbnJfcGFn
ZXMsCi0JCQkJCSAgICAgIE5VTEwsIE5VTEwsICZsb2NrZWQsCi0JCQkJCSAgICAgIEZPTExfVE9V
Q0ggfCBGT0xMX1dSSVRFKTsKLQkJaWYgKHJldCA8PSAwKQorCW1tYXBfcmVhZF9sb2NrKG1tKTsK
Kwlmb3IgKDsgbnN0YXJ0ICE9IGVuZDsgbnN0YXJ0ICs9IFBBR0VfU0laRSkgeworCQlpZiAoZml4
dXBfdXNlcl9mYXVsdChtbSwgbnN0YXJ0LCBmYXVsdF9mbGFncywgTlVMTCkpCiAJCQlicmVhazsK
LQkJbmVuZCA9IG5zdGFydCArIHJldCAqIFBBR0VfU0laRTsKIAl9Ci0JaWYgKGxvY2tlZCkKLQkJ
bW1hcF9yZWFkX3VubG9jayhtbSk7CisJbW1hcF9yZWFkX3VubG9jayhtbSk7CisKKwkvKiBJZiB3
ZSBnb3QgYWxsIG9mIG91ciAodHJ1bmNhdGVkKSBmYXVsdC1pbiwgd2UgY2xhaW0gd2UgZ290IGl0
IGFsbCAqLwogCWlmIChuc3RhcnQgPT0gZW5kKQogCQlyZXR1cm4gMDsKKworCS8qIC4uIG90aGVy
d2lzZSB3ZSdsbCB1c2UgdGhlIG9yaWdpbmFsIHVudHJ1bmNhdGVkIHNpemUgKi8KIAlyZXR1cm4g
c2l6ZSAtIG1pbl90KHNpemVfdCwgbnN0YXJ0IC0gc3RhcnQsIHNpemUpOwogfQogRVhQT1JUX1NZ
TUJPTChmYXVsdF9pbl9zYWZlX3dyaXRlYWJsZSk7Ci0tIAoyLjM1LjEuMzU2LmdlNjYzMGY1N2Nm
LmRpcnR5Cgo=
--0000000000003abc5505d9ba794e--
