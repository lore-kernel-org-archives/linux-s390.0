Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgKSJZl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 04:25:41 -0500
Subject: Re: [PATCH net-next 0/9] s390/qeth: updates 2020-11-17
References: <20201117161520.1089-1-jwi@linux.ibm.com>
 <20201118173517.4cfaa900@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <46384624-7fbe-fc18-9dd5-fb9c114a1868@linux.ibm.com>
Date: Thu, 19 Nov 2020 11:25:31 +0200
MIME-Version: 1.0
In-Reply-To: <20201118173517.4cfaa900@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On 19.11.20 03:35, Jakub Kicinski wrote:
> On Tue, 17 Nov 2020 17:15:11 +0100 Julian Wiedmann wrote:
>> please apply the following patch series for qeth to netdev's net-next tree.
>>
>> This brings some cleanups, and a bunch of improvements for our
>> .get_link_ksettings() code.
> 
> Applied, thanks!
> 

Thank you! Looks like you missed patch 1 in the series though... no biggie,
I'll resend it with the next batch of patches.
