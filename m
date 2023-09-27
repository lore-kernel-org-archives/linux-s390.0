Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF5E810DC
	for <linux-s390@archiver.kernel.org>; Wed, 27 Sep 2023 12:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjI0MpB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Sep 2023 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjI0MpA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Sep 2023 08:45:00 -0400
Received: from m4-bln.bund.de (m4-bln.bund.de [77.87.224.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA7E6
        for <linux-s390@vger.kernel.org>; Wed, 27 Sep 2023 05:44:58 -0700 (PDT)
Received: from m4-bln.bund.de (localhost [127.0.0.1])
        by m4-bln.bund.de (Postfix) with ESMTP id 9D7006AA91E
        for <linux-s390@vger.kernel.org>; Wed, 27 Sep 2023 14:44:56 +0200 (CEST)
Received: (from localhost) by m4-bln.bund.de (MSCAN) id 6/m4-bln.bund.de/smtp-gw/mscan;
     Wed Sep 27 14:44:56 2023
X-NdB-Source: NdB
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=itzbund.de;
        s=230316-2017-ed25519; t=1695818696;
        bh=JzV03SOJfmOsV1V8NePw9A1n04lNTFYSP415BNgFqJ4=;
        h=Date:From:To:Subject:MIME-Version:Content-Type:
         Content-Transfer-Encoding:Autocrypt:Cc:Content-Transfer-Encoding:
         Content-Type:Date:From:In-Reply-To:Mime-Version:Openpgp:References:
         Reply-To:Resent-To:Sender:Subject:To;
        b=6t3okHw8hnLe5FQEiCU3zMYqgHflOrOl7vO6fU0gxgSu5/kIBtw7bCzskr+oQLuis
         8efhE8DN1ukWejJELRfAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=itzbund.de;
        s=230316-2017-rsa; t=1695818695;
        bh=JzV03SOJfmOsV1V8NePw9A1n04lNTFYSP415BNgFqJ4=;
        h=Date:From:To:Subject:MIME-Version:Content-Type:
         Content-Transfer-Encoding:Autocrypt:Cc:Content-Transfer-Encoding:
         Content-Type:Date:From:In-Reply-To:Mime-Version:Openpgp:References:
         Reply-To:Resent-To:Sender:Subject:To;
        b=yBb+6UVbL1mWGPi9fsYTwqsSiWGooR41CoULc+wmLSMPaJlhU3sci74d0EVhW+r0j
         5iOXwsRaCGd43GY5Iy6/S9OnKAT7qcwfjY2nXzZ+/fWCu+dKBIhyUzqWaSOxAd5nMs
         TuJCJ2AojWDOmjjcDCG5npjuqBgvF8y2ztRlNvLicpm4+XxXMZ7Ey5dhMO8i5u/xW4
         3o3uEVAHkf9wjBtqdOTeIy2v5e0PtP0g8TCbGwmD3qjI2XEioaX7ttWCCrSBbo7mrF
         d9DDVI5/5Dt6rYY/zTY6o0YJDHETBobKXlvKbGq2gS2yfJkYVlhRtgk4FLxHebPzr2
         qvA+0qIquJlCw==
X-P350-Id: 28a11e38e0c076b4
Date:   Wed, 27 Sep 2023 14:44:55 +0200
From:   E-Mail-Administration ITZBund <noreply@itzbund.de>
To:     linux-s390@vger.kernel.org
Subject: Ihre E-Mail konnte nicht zugestellt werden
Message-ID: <20230927124455.GA120116@vlp22140.prod.groupware.itz.itzbund.net>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rusd: domwl, Pass through domain itzbund.de
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Sehr geehrte Damen und Herren,

bitte antworten Sie nicht auf diese Benachrichtigung. Kontaktm=F6glichkei=
ten entnehmen Sie bitte der E-Mail-Signatur.

Aufgrund eines Zertifikatsproblems auf einem Antivirus-Gateway des ITZBun=
d konnten E-Mails nicht zugestellt werden. Diese Nachrichten sollten dahe=
r noch einmal versendet werden.

Sie erhalten diese Benachrichtigung, da Ihre E-Mail-Adresse in einer der =
fraglichen Nachrichten enthalten war. Nachfolgend finden Sie die Einzelhe=
iten zu dieser E-Mail:

Datumsstempel: 25.09.2023 10:30

Absender: alibuda@linux.alibaba.com
Empf=E4nger: jaka@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.=
kernel.org, davem@davemloft.net, extern.martin.grimm@itzbund.de, wenjia@l=
inux.ibm.com, kgraul@linux.ibm.com

Betreff: 'Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() whil=
e closing listen socket'

Sollten Sie der Absender sein, so erw=E4gen Sie bitte den erneuten Versan=
d. In dem Fall, da=DF Sie diese E-Mail h=E4tten erhalten sollen, informie=
ren Sie bitte den Absender =FCber Ihren Wunsch, die E-Mail erneut zu vers=
enden.

Wir m=F6chten uns f=FCr die Unannehmlichkeiten entschuldigen.

F=FCr R=FCckfragen steht Ihnen die E-Mail-Administration des ITZBund gern=
e zur Verf=FCgung.


Freundliche Gr=FC=DFe

Ihre E-Mail-Administration
_______________________________________
V A 51 40 - Gateway-Systeme und Schnittstellen
Informationstechnikzentrum Bund (ITZBund)

Postanschrift: Postfach 301645, 53196 Bonn
E-Mail: VA5140@itzbund.de

