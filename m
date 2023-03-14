Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8005EC05027
	for <linux-s390@archiver.kernel.org>; Tue, 14 Mar 2023 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCNR0h (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCNR0g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 13:26:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F39C99F;
        Tue, 14 Mar 2023 10:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C9E9B819F6;
        Tue, 14 Mar 2023 17:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F12C4339B;
        Tue, 14 Mar 2023 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678814793;
        bh=/AjYsdeKz3/ZT6yxEbbyk1Cv8mFWK+qWnAMphe/pZsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgO2HU30/PeyB1p0xRf6TUVkypNHkbxLPi24EJV+zXqlSYmYZu3gGBnmCi7Z2qmP+
         uKNkIarlRm2bP5wa90KpPzCz8gQWGUgAJr5jmkDFVp+VPD8Z2V9gPUYGfSrhfJYPBC
         zXFVXvJZ5kLUkvU0xGiR5QW+31s0VG2vBlbLXliq8iW0WDIjiv507hDGnxbMLRzZQ6
         ewwKSF1YC08tawdWFTv0jPttiYRM+bqy434YTsgOM7e2Tcp4uQwc75BCVWHZ/geZJe
         oUtozSVv1Jo0wX4Wg48U6xRFgqCLVy7y4x5KRr5tzvrk17uWUcSNbTbY0opMQhftBu
         52Vk0fl6+iZNg==
Date:   Tue, 14 Mar 2023 13:26:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, cohuck@redhat.com,
        pasic@linux.ibm.com, farman@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.2 05/16] s390/virtio: sort out physical vs
 virtual pointers usage
Message-ID: <ZBCuSCIRrtdQQTeM@sashalap>
References: <20230305135207.1793266-1-sashal@kernel.org>
 <20230305135207.1793266-5-sashal@kernel.org>
 <167809840006.10483.605220541481258700@t14-nrb.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <167809840006.10483.605220541481258700@t14-nrb.local>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 06, 2023 at 11:26:40AM +0100, Nico Boehr wrote:
>Hi Sasha, s390 maintainers,
>
>Quoting Sasha Levin (2023-03-05 14:51:56)
>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> [ Upstream commit 5fc5b94a273655128159186c87662105db8afeb5 ]
>>
>> This does not fix a real bug, since virtual addresses
>> are currently indentical to physical ones.
>
>not sure if it is appropriate to pick for stable, since it does not fix a bug currently.
>
>Alexander, Janosch, your opinion?

I'll drop it, thanks!

-- 
Thanks,
Sasha
