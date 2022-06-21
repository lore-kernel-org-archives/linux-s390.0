Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F579C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Jun 2022 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiFUPbA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiFUPbA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 11:31:00 -0400
Received: from relay5.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF0622BE5
        for <linux-s390@vger.kernel.org>; Tue, 21 Jun 2022 08:30:59 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id CE03780FE9;
        Tue, 21 Jun 2022 15:30:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id F099A20012;
        Tue, 21 Jun 2022 15:30:55 +0000 (UTC)
Message-ID: <c65a542d9293667949ba74e7bae54f9dd7caa686.camel@perches.com>
Subject: Re: Re: [PATCH] net: s390: drop unexpected word "the" in the
 comments
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?=E8=92=8B=E5=81=A5?= <jiangjian@cdjrlc.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Cc:     wenjia <wenjia@linux.ibm.com>, hca <hca@linux.ibm.com>,
        gor <gor@linux.ibm.com>, agordeev <agordeev@linux.ibm.com>,
        borntraeger <borntraeger@linux.ibm.com>,
        svens <svens@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Jun 2022 08:30:55 -0700
In-Reply-To: <tencent_05711A707693017879EC87F7@qq.com>
References: <20220621113740.103317-1-jiangjian@cdjrlc.com>
         <09b411b2-0e1f-26d5-c0ea-8ee6504bdcfd@linux.ibm.com>
         <a502003f9ba31c660ddb9c9d8683b7b2a01d12f7.camel@perches.com>
         <tencent_05711A707693017879EC87F7@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: F099A20012
X-Stat-Signature: 8knhxrmrgmu8k4hk9worbcetgyxdb9dr
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19rgz/bWlKy+zCDv3jFjhLJJqGzyhLHl2I=
X-HE-Tag: 1655825455-267590
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2022-06-21 at 23:21 +0800, 蒋健 wrote:
> So,i need to resubmit a new patch ?&nbsp;

Not necesarily no.  Up to you.

And this is a quite old driver that likely doesn't need much
change so if there is a patch at all, maybe simpler is better.

(though all the uses like ?&nbsp; in your reply could be a
 reason to either update or perhaps reconfigure your
 X-Mailer: QQMail 2.x email client)

cheers, Joe
