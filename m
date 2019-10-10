Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJJCvU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 22:51:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so2887900pfg.13
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 19:51:20 -0700 (PDT)
Date: Wed, 9 Oct 2019 19:51:06 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net-next 0/5] net/smc: improve termination handling
Message-ID: <20191009195106.081db8d8@cakuba.netronome.com>
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Wed,  9 Oct 2019 10:07:42 +0200, Karsten Graul wrote:
> First set of patches to improve termination handling.

Applied, thanks.

Out of curiosity why does net/sock.h have to include net/smc.h?
This SMC-specific series causes half of the kernel to rebuild =F0=9F=A4=A8
