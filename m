Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD57C43334
	for <linux-s390@archiver.kernel.org>; Tue, 12 Jul 2022 10:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGLKY3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiGLKY2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Jul 2022 06:24:28 -0400
X-Greylist: delayed 1888 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 03:24:26 PDT
Received: from m1564.mail.126.com (m1564.mail.126.com [220.181.15.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D91ADD6E
        for <linux-s390@vger.kernel.org>; Tue, 12 Jul 2022 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=B8roZ
        I7C9VYssQt3Uu6DLBmOWrjdoGs4ebLDpR6yl3c=; b=NsVfT8KvXcDQaLilzZN0D
        AAW9N8ctWPvSHdCxLYO301BfXJUqgAFAQFPbGShaKJpkbaC0Jaa7T14inmeaOGYP
        cSpNZeq+c+wTmOLpPkBAJFVFpenyAuZWes0kuwmzU0SW2hqnd1mLxEfngV5yt4Fe
        HKsj1DvDhn0zT2rpiVtsq4=
Received: from sohu0106$126.com ( [119.3.119.21] ) by ajax-webmail-wmsvr64
 (Coremail) ; Tue, 12 Jul 2022 17:52:51 +0800 (CST)
X-Originating-IP: [119.3.119.21]
Date:   Tue, 12 Jul 2022 17:52:51 +0800 (CST)
From:   sohu0106 <sohu0106@126.com>
To:     vneethv@linux.ibm.com, oberpar@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: buffer overflow in
 vfio_ccw_async_region_write/vfio_ccw_async_region_read
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <255c7ef5.6bf9.181f1d3637e.Coremail.sohu0106@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowABXX3NzRM1ihk9KAA--.8055W
X-CM-SenderInfo: pvrk3iqrqwqiyswou0bp/1tbi7Qk8HlpEAYe-xQABsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

CkluIHRoZSB2ZmlvX2Njd19hc3luY19yZWdpb25fd3JpdGUvdmZpb19jY3dfYXN5bmNfcmVnaW9u
X3JlYWQgZnVuY3Rpb24gb2YgZHJpdmVycy9zMzkwL2Npby92ZmlvX2Njd19hc3luYy5jLCBwYXJh
bWV0ZXIgInNpemVfdCBjb3VudCIgaXMgcGFzcyBieSB1c2VybGFuZCwgaWYgImNvdW50IiBpcyB2
ZXJ5IGxhcmdlLCBpdCB3aWxsIGJ5cGFzcyAiaWYgKHBvcyArIGNvdW50ID4gc2l6ZW9mKCpyZWdp
b24pKSIuKHN1Y2ggYXMgY291bnQ9MHhmZmZmZmZmZikuIFRoZW4gaXQgd2lsbCBsZWFkIHRvIGJ1
ZmZlciBvdmVyZmxvdyBpbiAiY29weV9mcm9tX3VzZXIoKHZvaWQgKilyZWdpb24gKyBwb3MsIGJ1
ZiwgY291bnQpIi7CoAoKCgoKZGlmZiAtLWdpdCBhL3ZmaW9fY2N3X2FzeW5jLmNfb3JnIGIvdmZp
b19jY3dfYXN5bmMuYwppbmRleCA3YTgzOGUzLi4zMzMzOWFkIDEwMDY0NAotLS0gYS92ZmlvX2Nj
d19hc3luYy5jX29yZworKysgYi92ZmlvX2Njd19hc3luYy5jCkBAIC0yMSw3ICsyMSw3IEBAIHN0
YXRpYyBzc2l6ZV90IHZmaW9fY2N3X2FzeW5jX3JlZ2lvbl9yZWFkKHN0cnVjdCB2ZmlvX2Njd19w
cml2YXRlICpwcml2YXRlLArCoCDCoCDCoCDCoCBzdHJ1Y3QgY2N3X2NtZF9yZWdpb24gKnJlZ2lv
bjsKwqAgwqAgwqAgwqAgaW50IHJldDsKCgotwqAgwqAgwqAgwqBpZiAocG9zICsgY291bnQgPiBz
aXplb2YoKnJlZ2lvbikpCivCoCDCoCDCoCDCoGlmIChwb3MgKyBjb3VudCA+IHNpemVvZigqcmVn
aW9uKSAmJiBwb3MgKyBjb3VudCA+IHBvcykKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJu
IC1FSU5WQUw7CgoKwqAgwqAgwqAgwqAgbXV0ZXhfbG9jaygmcHJpdmF0ZS0+aW9fbXV0ZXgpOwpA
QCAtNDMsNyArNDMsNyBAQCBzdGF0aWMgc3NpemVfdCB2ZmlvX2Njd19hc3luY19yZWdpb25fd3Jp
dGUoc3RydWN0IHZmaW9fY2N3X3ByaXZhdGUgKnByaXZhdGUsCsKgIMKgIMKgIMKgIHN0cnVjdCBj
Y3dfY21kX3JlZ2lvbiAqcmVnaW9uOwrCoCDCoCDCoCDCoCBpbnQgcmV0OwoKCi3CoCDCoCDCoCDC
oGlmIChwb3MgKyBjb3VudCA+IHNpemVvZigqcmVnaW9uKSkKK8KgIMKgIMKgIMKgaWYgKHBvcyAr
IGNvdW50ID4gc2l6ZW9mKCpyZWdpb24pICYmIHBvcyArIGNvdW50ID4gcG9zKQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm4gLUVJTlZBTDsKCgrCoCDCoCDCoCDCoCBpZiAoIW11dGV4X3Ry
eWxvY2soJnByaXZhdGUtPmlvX211dGV4KSkKCg==
