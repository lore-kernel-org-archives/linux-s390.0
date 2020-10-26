Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407409AbgJZXj6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 19:39:58 -0400
Date: Mon, 26 Oct 2020 16:39:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 0/3] net/smc: fixes 2020-10-23
Message-ID: <20201026163949.35f94fde@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201023184830.59548-1-kgraul@linux.ibm.com>
References: <20201023184830.59548-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On Fri, 23 Oct 2020 20:48:27 +0200 Karsten Graul wrote:
> Please apply the following patch series for smc to netdev's net tree.
> 
> Patch 1 fixes a potential null pointer dereference. Patch 2 takes care
> of a suppressed return code and patch 3 corrects the system EID in the
> ISM driver.

Applied, thanks!
