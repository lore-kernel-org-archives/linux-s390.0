Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D4C197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 19:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjKPTOm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 14:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjKPTOl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 14:14:41 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01833D56
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 11:14:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so721545b6e.3
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 11:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162077; x=1700766877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXMlqUa9U+ONyBzylSfeWWc20gFnP/0YsPE87Yq0BOQ=;
        b=PRSE2M1ORVm7fO5vG8Ol92WXrkNFp1x4Oy4Ag4nrtHgrOIrnbZ0jg6YTpNCajdevk5
         97ne8VGKG1rug+OceA7nx3KYfmKYTxue2zaKWIrCE87GBPG4NjQwhhubH3IbCIKga0QH
         s479EnroSES6n+gmAttCGt3lzQsoWatPNMQns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162077; x=1700766877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXMlqUa9U+ONyBzylSfeWWc20gFnP/0YsPE87Yq0BOQ=;
        b=mbRO61QU/k3k/xLaSZZrRHZcAHPpeiuM20unTknukSXh/l2/Zt9G1/OjoHbuGyKjUF
         DB/6zzjEVXTWVprDaTWnl/fEZOTnH8TFORF4lrvzvTYLwQpsmgOaWbarXO+ZmRBQYcT1
         AeEVnCq7oSOWGoVRTQMFHOjsxISk3hu9JbpvVC2oJnwJ4bsbX3luGc4aGU/YcB1bI1Ys
         gcMF2GdVwJT/PrzKaNP1EK/IN1aFJ0yyVhWR845bfTTS1Ir5XWp86NitS0+9woX0PnN3
         hETX7881Exuc3hPt+yWcj9qlUf/zzD/qBG4B6NQJI7TJNXKVKds3knDs8H3q17w2FThT
         810A==
X-Gm-Message-State: AOJu0YyctfRvkHc3c3qor8Oge9Ek4au7yvjIifPS595ZexEmFm3Iq0sU
        Qu6exUzfpFSxXMhOOQSxJDd6Ew==
X-Google-Smtp-Source: AGHT+IHz54MaNBa/FlcHGXRN1pIxZE4ZigsrM1BRWw9tGvly2N+Ep0QSYPAXnBIoJfAHeM0CxPSDnQ==
X-Received: by 2002:a05:6808:13cc:b0:3b2:e6a4:e177 with SMTP id d12-20020a05680813cc00b003b2e6a4e177mr24284312oiw.51.1700162077185;
        Thu, 16 Nov 2023 11:14:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y17-20020a63e251000000b005ab7b055573sm47469pgj.79.2023.11.16.11.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:14:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: zfcp: Replace strlcpy() with strscpy()
Date:   Thu, 16 Nov 2023 11:14:35 -0800
Message-Id: <20231116191435.work.581-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=keescook@chromium.org;
 h=from:subject:message-id; bh=n/5QOMTS/PQ87jfirRVAutDJEB7F5Jn3WLO02CU/Zxk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmobOo7x61Ke/67MhKfWOLSNoGNoSj987Uk83
 vjr19oRi1OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZqGwAKCRCJcvTf3G3A
 JnY/D/wJJH1WvSnfcOFsHJ7ya6qtSFf2j4ns7EUFNJSsRvSJTm16bUOEbYBISKfoDSA0nJl9QdC
 Kq1Kdoo/POkGyIJaVT1ksnnKoo1CaomOCqIXxC0BvUjoUzKGVaRQx3UxVRx1tznTM1srcjzdbDo
 EL7KzXzBmD2fRaI9tdtxujifs4qF5H8lX7+LlgKiGWD97An4mlPxktKW5vdO0N4n+lNN9pYsC5Y
 sOr9Lfo9CqR9l0PdxAK+GG7f0orxLMKxpCr/CbjYyR6epEgG430To5caSUabjbcpYum0Eckl4pp
 AJvL8FPevJbV8mBBh9CGwzuPyUhotxw/mmeq1mMxWqDcCH9WMOwiqOW9exZGun+BT2oba/EjWWM
 7doqbdFNhFoCMTx3oBuCpBgzo+grrxYBi8w4gfnqP4ax7K70EnGtmYWbTPkyFWs2L3IEeC2g25j
 jJmf7RRM9gVipZQG4MEW8qn1RYQR5vxvbDUs8sgKP3QEw6TBzKQ8AdY18O49jUDrsFrYUp8isAn
 j5DXCRqc8rxHuxrH0RdeEa3/uMOtPNEJUGEOkKQ3/5SZekJBQ0oIUtX5o47qCSUHAzRq6CmNhA+
 xUaww+US21aOvGxxpOSr72MJoDcCSgyOWR2Y8Tr75noNYgECiTwUxEgA0Gj+rPi9UcOOB4Fer5V
 PlWWlQh bp1J2Obw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Be explicitly robust in the face of truncation, which should be an
impossible state.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Steffen Maier <maier@linux.ibm.com>
Cc: Benjamin Block <bblock@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/scsi/zfcp_fc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 4f0d0e55f0d4..1a29f10767fc 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -900,8 +900,15 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
 	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
 			   FC_SYMBOLIC_NAME_SIZE);
 	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
-	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
-		      FC_SYMBOLIC_NAME_SIZE);
+	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
+		      sizeof(rspn_req->name));
+	/*
+	 * It should be impossible for this to truncate, as
+	 * sizeof(rspn_req->name) is equal to max size of
+	 * fc_host_symbolic_name(shost), but check anyway.
+	 */
+	if (len < 0)
+		len = sizeof(rspn_req->name) - 1;
 	rspn_req->rspn.fr_name_len = len;
 
 	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));
-- 
2.34.1

