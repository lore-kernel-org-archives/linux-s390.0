Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CBC7EE29
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jun 2023 08:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFAILQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFAILP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jun 2023 04:11:15 -0400
Received: from mail.tipvortexbiz.com (mail.tipvortexbiz.com [51.254.102.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD549F
        for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 01:11:12 -0700 (PDT)
Received: by mail.tipvortexbiz.com (Postfix, from userid 1002)
        id 90D4B46CA0; Thu,  1 Jun 2023 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tipvortexbiz.com;
        s=mail; t=1685607070;
        bh=P1Han34balTJAB06sltOuaQxWoVYtmotA0/1aw855g4=;
        h=Date:From:To:Subject:From;
        b=oxvbb+uinCEA05m3m5WQUMycPBrlBdx9samPyUizxrivg1a57IWDlCClBxwhCMnCY
         IosPFPb7HD5AdkneuwspbiWvDLKrbBildBru7kFi0qq+eeN98fqTsQuFXO+kAh6fBl
         PlM2vw7WgSG5hRnQdlFvhx+znNWSKVN6s0zRLjtAuW/YPwE8UPrHYoGDrxkgZBcKej
         YRbGXDIwqv2cEE/g+oKsA5SDSf2Tgts0I0Mb7X1oonSJmMMewHafjPsSumT9rTM7CY
         O9jsZvESx4jEv8VL185CJ+bpXW+9aJ4XSKqK4PW3tpixmpMdyFRg78w7u6hMPZrD1x
         jOpNusqAccKdQ==
Received: by mail.tipvortexbiz.com for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 08:11:01 GMT
Message-ID: <20230601064500-0.1.22.4g2b.0.bsq62in9hk@tipvortexbiz.com>
Date:   Thu,  1 Jun 2023 08:11:01 GMT
From:   "Victor Pollard" <victor.pollard@tipvortexbiz.com>
To:     <linux-s390@vger.kernel.org>
Subject: Wake up - Audit time
X-Mailer: mail.tipvortexbiz.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Good morning,

we provide a solution that significantly shortens the audit time, enables=
 standards control and non-compliance reporting:

=E2=97=8F Audits - to check quality or process standards (ISO, 5S, LPA)
=E2=97=8F Scheduler - all work can be scheduled and linked to the notific=
ation system
=E2=97=8F Checklists - for carrying out work "point by point" with a desc=
ription illustrated with a photo or video
=E2=97=8F Non-conformances - immediately report non-conformances and send=
 them to responsible persons
=E2=97=8F Tests - to check knowledge after training or (customer's) expec=
tations
=E2=97=8F Summary of Results and Reports - presented on dashboards

Are you open to a conversation about using such a tool in your company?


Regards
Victor Pollard
