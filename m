Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C2ECD5489
	for <linux-s390@archiver.kernel.org>; Tue, 19 Sep 2023 07:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjISHhf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjISHhd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Sep 2023 03:37:33 -0400
X-Greylist: delayed 372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:37:25 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF46FC
        for <linux-s390@vger.kernel.org>; Tue, 19 Sep 2023 00:37:24 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 492CD76133E; Tue, 19 Sep 2023 09:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108670; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=Qh3sDIlcymF64O39FX5fqQQpEqykxWzCjjiAoGFWjKOX/aE4nmPs2hbt+o0yYByY8
         vZ8HHbjOR39nHc+dnAgiPu5FxZRLeBljLIXod+TPdseh+M04Bz4BR0LvPHWqRWcBPS
         FpQdZz+mZYJB9JBYZfFY3PtcDXwxMFjjXIrbRIRfqqSq0XM311VvGd41rni7NRWuJj
         mFl9o3YjEf6UvjRmJBeU7TdUfxi8aeQT6HIgvmLJ8stcCOwga1zdkFpqBPWFsBOVIc
         aeADabPHdXuZ7UNXrWdTeycf1MUF43X8Q3bBm+9UgVTGFDJV7oNKKZA83OiwxZm8Hw
         P/NS31zYVu1hA==
Received: by mail.leeswilly.pl for <linux-s390@vger.kernel.org>; Tue, 19 Sep 2023 07:30:18 GMT
Message-ID: <20230919084500-0.1.3z.bbnr.0.03epnu7hk2@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:30:18 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-s390@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak
