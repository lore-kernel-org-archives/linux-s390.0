Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbfKHMA1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 8 Nov 2019 07:00:27 -0500
Date: Fri, 8 Nov 2019 07:00:25 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload
 erratum to L3 devices
Message-ID: <20191108120025.GM4787@sasha-vm>
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-204-sashal@kernel.org>
 <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org

On Fri, Nov 08, 2019 at 12:50:24PM +0100, Julian Wiedmann wrote:
>On 08.11.19 12:37, Sasha Levin wrote:
>> From: Julian Wiedmann <jwi@linux.ibm.com>
>>
>> [ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]
>>
>> Combined L3+L4 csum offload is only required for some L3 HW. So for
>> L2 devices, don't offload the IP header csum calculation.
>>
>
>NACK, this has no relevance for stable.

Sure, I'll drop it.

Do you have an idea why the centos and ubuntu folks might have
backported this commit into their kernels?

-- 
Thanks,
Sasha
