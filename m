Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39386 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfJKCRK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 22:17:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so11719289qtb.6
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 19:17:10 -0700 (PDT)
Date: Thu, 10 Oct 2019 19:16:53 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v2 net 0/3] net/smc: fixes for -net
Message-ID: <20191010191653.35c93381@cakuba.netronome.com>
In-Reply-To: <20191010081611.35446-1-kgraul@linux.ibm.com>
References: <20191010081611.35446-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Thu, 10 Oct 2019 10:16:08 +0200, Karsten Graul wrote:
> Fixes for -net, addressing two races in SMC receive path and
> add a missing cleanup when the link group creating fails with
> ISM devices and a VLAN id.
> 
> v1->v2:
> - added fixes tags

Applied, queued for stable
