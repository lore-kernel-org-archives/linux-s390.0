Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07CC433B4
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 02:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5699660FF1
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 02:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhDHCsN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Apr 2021 22:48:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16071 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHCsM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Apr 2021 22:48:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG5H12lN2z1BGPn;
        Thu,  8 Apr 2021 10:45:49 +0800 (CST)
Received: from [10.174.178.140] (10.174.178.140) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 10:47:53 +0800
Subject: Re: [PATCH] s390/pci: move
 ioremap/ioremap_prot/ioremap_wc/ioremap_wt/iounmap to arch/s390/mm/ioremap.c
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>
CC:     <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <john.wanghui@huawei.com>
References: <20210401124611.49917-1-cuibixuan@huawei.com>
 <a3005d2871d6571a436dacca2d93eb10cca54bed.camel@linux.ibm.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <d87946d9-dfa6-e279-e9e6-89f6276dc03c@huawei.com>
Date:   Thu, 8 Apr 2021 10:47:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a3005d2871d6571a436dacca2d93eb10cca54bed.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.140]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2021/4/6 19:14, Niklas Schnelle wrote:
> and move the have_mio variable out of the PCI only code or use a raw
> "#ifdef CONFIG_PCI". Obviously we don't have any actual users of
> ioremap() that don't depend on CONFIG_PCI but it would make it so that
> ioremap() exists and should actually function without CONFIG_PCI.
> The weird part though is that for anyone using it without CONFIG_PCI it
> would stop working if that is set and the machine doesn't have MIO
> support but would work if it does.
Well, Maybe it's better not to change it.And thank you for the explanation.

Thanks，
Bixuan Cui
