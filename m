Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgE2Wjc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 May 2020 18:39:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD7C08C5CB
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2020 15:39:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so2054950pjd.0
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2020 15:39:30 -0700 (PDT)
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <20200529202713.GC19604@bombadil.infradead.org>
 <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0fc36e-fa67-a6b9-cc7a-d86d3f21cf2c@kernel.dk>
Date: Fri, 29 May 2020 16:39:26 -0600
MIME-Version: 1.0
In-Reply-To: <c7a5bbc4-ffc2-6a63-fed3-9874969afc31@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Matthew Wilcox <willy@infradead.org>, Kaitao Cheng <pilgrimtao@gmail.com>
Cc: hch@lst.de, sth@linux.ibm.com, viro@zeniv.linux.org.uk, clm@fb.com, jaegeuk@kernel.org, hch@infradead.org, mark@fasheh.com, dhowells@redhat.com, balbi@kernel.org, damien.lemoal@wdc.com, ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com, chaitanya.kulkarni@wdc.com, houtao1@huawei.com, asml.silence@gmail.com, ajay.joshi@wdc.com, linux-kernel@vger.kernel.org, songmuchun@bytedance.com, hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net, darrick.wong@oracle.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, ocfs2-devel@oss.oracle.com, deepa.kernel@gmail.com

On 5/29/20 4:27 PM, Bart Van Assche wrote:
> On 2020-05-29 13:27, Matthew Wilcox wrote:
>> On Fri, May 29, 2020 at 10:11:00PM +0800, Kaitao Cheng wrote:
>>> There is a function named ilog2() exist which can replace blksize.
>>> The generated code will be shorter and more efficient on some
>>> architecture, such as arm64. And ilog2() can be optimized according
>>> to different architecture.
>>
>> We'd get the same benefit from a smaller patch with just:
>>
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1502,15 +1502,9 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>>  	return !(addr & alignment) && !(len & alignment);
>>  }
>>  
>> -/* assumes size > 256 */
>>  static inline unsigned int blksize_bits(unsigned int size)
>>  {
>> -	unsigned int bits = 8;
>> -	do {
>> -		bits++;
>> -		size >>= 1;
>> -	} while (size > 256);
>> -	return bits;
>> +	return ilog2(size);
>>  }
>>  
>>  static inline unsigned int block_size(struct block_device *bdev)
> 
> Hi Matthew,
> 
> I had suggested to change all blksize_bits() calls into ilog2() calls
> because I think that a single function to calculate the logarithm base 2
> is sufficient.

I think this should be a two-parter:

1) Use the inode blkbits where appropriate
2) Then do this change

I'm leaning towards just doing it in blksize_bits() instead of updating
every caller, unless there aren't that many left once we've gone
through patch 1.

-- 
Jens Axboe
