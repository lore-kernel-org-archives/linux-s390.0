Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42975 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfJJCCY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 22:02:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so2834661pff.9
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 19:02:24 -0700 (PDT)
Date: Wed, 9 Oct 2019 19:02:10 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net 0/3] net/smc: fixes for -net
Message-ID: <20191009190210.4592990b@cakuba.netronome.com>
In-Reply-To: <20191009080441.76077-1-kgraul@linux.ibm.com>
References: <20191009080441.76077-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Wed,  9 Oct 2019 10:04:38 +0200, Karsten Graul wrote:
> Fixes for -net, more info in commit logs.

Please write a sentence or two describing the nature of the fixes.
This message ends up in merge commits in the tree, pointing at the
commits themselves is unhelpful.

Please provide Fixes tags pointing at the commit which introduced the
bug in all of the patches.

Thank you.
