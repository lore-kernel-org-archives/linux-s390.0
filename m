Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DAC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Jun 2022 15:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbiFUPB1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiFUPB1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 11:01:27 -0400
Received: from relay3.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0426570
        for <linux-s390@vger.kernel.org>; Tue, 21 Jun 2022 08:01:24 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 1D50E351D9;
        Tue, 21 Jun 2022 15:01:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id B87FD2000F;
        Tue, 21 Jun 2022 15:01:18 +0000 (UTC)
Message-ID: <a502003f9ba31c660ddb9c9d8683b7b2a01d12f7.camel@perches.com>
Subject: Re: [PATCH] net: s390: drop unexpected word "the" in the comments
From:   Joe Perches <joe@perches.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Jiang Jian <jiangjian@cdjrlc.com>
Cc:     wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jun 2022 08:01:17 -0700
In-Reply-To: <09b411b2-0e1f-26d5-c0ea-8ee6504bdcfd@linux.ibm.com>
References: <20220621113740.103317-1-jiangjian@cdjrlc.com>
         <09b411b2-0e1f-26d5-c0ea-8ee6504bdcfd@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: nbwwtqkrsbqnzwh9ramyn7pzw1fuzn1n
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B87FD2000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+sUyxK4FFvpDjZtlXFNMosIz2P+MhhHMw=
X-HE-Tag: 1655823678-383585
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2022-06-21 at 13:58 +0200, Alexandra Winter wrote:
> On 21.06.22 13:37, Jiang Jian wrote:
> > there is an unexpected word "the" in the comments that need to be dropped
[]
> > * have to request a PCI to be sure the the PCI
> > * have to request a PCI to be sure the PCI
[]
> > diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
[]
> > @@ -3565,7 +3565,7 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
> >  			if (!atomic_read(&queue->set_pci_flags_count)) {
> >  				/*
> >  				 * there's no outstanding PCI any more, so we
> > -				 * have to request a PCI to be sure the the PCI

Might have intended "that the" and not "the the"

> > +				 * have to request a PCI to be sure the PCI
> >  				 * will wake at some time in the future then we
> >  				 * can flush packed buffers that might still be
> >  				 * hanging around, which can happen if no

And this is a relatively long sentence.

Perhaps something like:

			if (!atomic_read(&queue->set_pci_flags_count)) {
				/*
				 * there's no outstanding PCI any more so:
				 * o request a PCI to be sure that the PCI
				 *   will wake at some time in the future
				 * o flush packed buffers that might still be
				 *   hanging around (which can happen if no
				 *   further send was requested by the stack)
				 */

