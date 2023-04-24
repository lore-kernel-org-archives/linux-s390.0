Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA32C77B76
	for <linux-s390@archiver.kernel.org>; Mon, 24 Apr 2023 22:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjDXWgT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDXWgD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Apr 2023 18:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6224658A;
        Mon, 24 Apr 2023 15:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FF29629D9;
        Mon, 24 Apr 2023 22:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164E0C433D2;
        Mon, 24 Apr 2023 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1682375761;
        bh=JUKZ2Hs9/htC0zzfnmoGs26A5T6CXo9vY2LrTZkkL8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fuuz51ZP8E4g8Tp5ErfnuI8Fcgtbfv8oC4n34/gtTaI+UgORIlT9iPF4rEgWswDXG
         xci+uBoMUzVFpciGUwJN6Elx4qtDHSSRGkpy0ANUZ+WBvlHJyUgryGL6hFUsUJYAId
         KdRVhAxdP6ZeAwEVgsU7fuNNBQc6puvIGJsNdMgo=
Date:   Mon, 24 Apr 2023 15:36:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH mm-stable v2 0/3] mm/ksm: improve PR_SET_MEMORY_MERGE=0
 handling and cleanup disabling KSM
Message-Id: <20230424153600.a0a6150ac5673d84dbd9f4f0@linux-foundation.org>
In-Reply-To: <20230422205420.30372-1-david@redhat.com>
References: <20230422205420.30372-1-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 22 Apr 2023 22:54:17 +0200 David Hildenbrand <david@redhat.com> wrote:

> This is a follow-up to [1]:
> 	[PATCH v9 0/3] mm: process/cgroup ksm support
> 
> which is now in mm-stable. Ideally we'd get at least patch #1 into the
> same kernel release as [1], so the semantics of setting
> PR_SET_MEMORY_MERGE=0 are unchanged between kernel versions.

Ack.  I'll prepare a second followon MM batch for Linus latish in the
merge window for material such as this.

