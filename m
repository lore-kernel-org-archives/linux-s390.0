Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQif (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 11:38:35 -0500
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com> <20201118154944.GB545@redhat.com>
 <20201118160748.GA754@redhat.com>
 <7ae2b73e-e6e5-3357-11e4-efd93e93ba35@de.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3116ea60-1dc3-9c15-31ec-5ce8ef72ba1a@infradead.org>
Date: Wed, 18 Nov 2020 08:38:27 -0800
MIME-Version: 1.0
In-Reply-To: <7ae2b73e-e6e5-3357-11e4-efd93e93ba35@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Mike Snitzer <snitzer@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On 11/18/20 8:35 AM, Christian Borntraeger wrote:
> 
> 
> On 18.11.20 17:07, Mike Snitzer wrote:
>> On Wed, Nov 18 2020 at 10:49am -0500,
>> Mike Snitzer <snitzer@redhat.com> wrote:
>>
>>> I don't think my suggestion will help.. given it'd still leave
>>> persistent_memory_claim() without a return statement.
>>>
>>> Think it worthwhile to just add a dummy 'return 0;' after the BUG().
>>
>> Decided to go with this, now staged for 5.11:
>> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1
>>
> 
> Looks like a sane solution. Thank you for following up.

Yes, thanks again.

-- 
~Randy
