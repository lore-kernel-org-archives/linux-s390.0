Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44982 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJJBFZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 21:05:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so6216268qth.11
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 18:05:25 -0700 (PDT)
Date: Wed, 9 Oct 2019 18:05:09 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net 0/2] s390/qeth: fixes 2019-10-08
Message-ID: <20191009180509.74cb1ce6@cakuba.netronome.com>
In-Reply-To: <20191008162107.95259-1-jwi@linux.ibm.com>
References: <20191008162107.95259-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On Tue,  8 Oct 2019 18:21:05 +0200, Julian Wiedmann wrote:
> Hi Dave,
> 
> please apply the following two patches to your net tree.
> 
> Alexandra fixes two issues in the initialization code for vnicc cmds.
> One is an uninitialized variable when a cmd fails, the other that we
> wouldn't recover correctly if the device's supported features changed.

Applied, and queued for stable.
