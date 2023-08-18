Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE8C05052
	for <linux-s390@archiver.kernel.org>; Fri, 18 Aug 2023 09:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbjHRJCy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359013AbjHRJCU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Aug 2023 05:02:20 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:58 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BEE3C26
        for <linux-s390@vger.kernel.org>; Fri, 18 Aug 2023 02:01:58 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 1BE8584819; Fri, 18 Aug 2023 09:16:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346627; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=MyIpcAhqPAGkE7u+owDeDz68IJdbeyfTXOJi63jcUxpreiOgqYQXvWsUyGeUeu316
         BGdJ4CNZIOxkeRwESsyslgLhJEhLzoqyT7FtXwWaBgst2DRtrAdiw/RE3PxvoSrISj
         vNFZQosN9O87QtCtlemobUZEgMuvmg0Kox/DKyN9PfOVTo6vJnW/H+xXdy5tecTH+R
         7Cy+5xqXAmmXa85liwa+l9/oCqAg0v/9mTs4HxQJt4lCjaBWnHmTswQZHPHKs/aduv
         AX34j4NYJbyjFNATyqNAbb3hKQUinCR/ehMzF+dL2uSd6FJxBU0PdxvqZVm6bIlE4K
         0Fyn3Ng8W/lSg==
Received: by mail.leachkin.pl for <linux-s390@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cumu.0.g4n1r0ui5g@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-s390@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
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


Pozdrawiam,
Jakub Lemczak
