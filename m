Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729504AbgAOJzJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 04:55:09 -0500
Subject: Fwd: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
References: <20200114161857.GD3929@suse.cz>
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <e66fa494-e137-ed73-6db3-15fcbd232eb7@linux.ibm.com>
Date: Wed, 15 Jan 2020 10:54:53 +0100
MIME-Version: 1.0
In-Reply-To: <20200114161857.GD3929@suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Andrew,

Could you please pick this V4 btrfs patch and the other five patches from V3 patch
set (https://lkml.org/lkml/2020/1/3/568).

Older patches can be dropped from linux-next:
 * ac2aeaa0f4d3 btrfs: use larger zlib buffer for s390 hardware compression
 * ac19f15aea33 lib/zlib: add zlib_deflate_dfltcc_enabled() function
 * 3447c9a51196 s390/boot: add dfltcc= kernel command line parameter
 * 890060df4401 lib/zlib: add s390 hardware support for kernel zlib_inflate
 * 148f7d060405 s390/boot: rename HEAP_SIZE due to name collision
 * bfbef17740fd lib/zlib: add s390 hardware support for kernel zlib_deflate

Thanks,
Mikhail.


-------- Forwarded Message --------
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware compression
Date: Tue, 14 Jan 2020 17:18:57 +0100
From: David Sterba <dsterba@suse.cz>
Reply-To: dsterba@suse.cz
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:51:03AM +0100, Mikhail Zaslonko wrote:
> In order to benefit from s390 zlib hardware compression support,
> increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
> s390 zlib hardware support is enabled on the machine). This brings up
> to 60% better performance in hardware on s390 compared to the PAGE_SIZE
> buffer and much more compared to the software zlib processing in btrfs.
> In case of memory pressure, fall back to a single page buffer during
> workspace allocation.
> The data compressed with larger input buffers will still conform to zlib
> standard and thus can be decompressed also on a systems that uses only
> PAGE_SIZE buffer for btrfs zlib.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Reviewed-by: David Sterba <dsterba@suse.com>
