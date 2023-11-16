Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A9C197A0
	for <linux-s390@archiver.kernel.org>; Thu, 16 Nov 2023 06:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKPGAi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Nov 2023 01:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPGAf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 01:00:35 -0500
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 22:00:31 PST
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D524F1AB
        for <linux-s390@vger.kernel.org>; Wed, 15 Nov 2023 22:00:31 -0800 (PST)
Message-ID: <5ff45ce6-f1bb-462c-9b1e-aadfb881808a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700113983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsIP/VS6rGR5s3xC9mmdYDIoDcaS13Pz0T89+vNaTAk=;
        b=DmWs2odRAbR9UXAs7DJezIyJcKyNZrvfke/ZoWgguDvL3EVnvc9GJAUc/8oKirKTmGzkGb
        a3lUpNULgGHjyON97B7BTat1mkY+y0/X6crxcTDbTUJILiffsOWt6h2C5JVl9MJL9VeJUN
        R2cERV9pyH+UfI+kJJyQCXUzDMmTBVw=
Date:   Thu, 16 Nov 2023 00:52:56 -0500
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
Content-Language: en-GB
To:     Hou Tao <houtao@huaweicloud.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev>
 <20231115153139.29313-A-hca@linux.ibm.com>
 <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 11/15/23 8:15 PM, Hou Tao wrote:
> Hi,
>
> On 11/15/2023 11:31 PM, Heiko Carstens wrote:
>> On Sun, Aug 27, 2023 at 08:27:34AM -0700, Yonghong Song wrote:
>>> This is needed for later percpu mem allocation when the
>>> allocation is done by bpf program. For such cases, a global
>>> bpf_global_percpu_ma is added where a flexible allocation
>>> size is needed.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/linux/bpf.h   |  4 ++--
>>>   kernel/bpf/core.c     |  8 +++++---
>>>   kernel/bpf/memalloc.c | 14 ++++++--------
>>>   3 files changed, 13 insertions(+), 13 deletions(-)
>> Both Marc and Mikhail reported out-of-memory conditions on s390 machines,
>> and bisected it down to this upstream commit 41a5db8d8161 ("bpf: Add
>> support for non-fix-size percpu mem allocation").
>> This seems to eat up a lot of memory only based on the number of possible
>> CPUs.
>>
>> If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
>> this is a realistic scenario) the memory consumption directly after boot
>> is:
>>
>> $ cat /sys/devices/system/cpu/present
>> 0-5
>> $ cat /sys/devices/system/cpu/possible
>> 0-511
> Will the present CPUs be hot-added dynamically and eventually increase
> to 512 CPUs ? Or will the present CPUs rarely be hot-added ? After all
> possible CPUs are online, will these CPUs be hot-plugged dynamically ?
> Because I am considering add CPU hotplug support for bpf mem allocator,
> so we can allocate memory according to the present CPUs instead of
> possible CPUs. But if the present CPUs will be increased to all possible
> CPUs quickly, there will be not too much benefit to support hotplug in
> bpf mem allocator.

Thanks, Hou. In my development machine and also checking
some internal production machines, no suprisingly, the 'present' number
cpus is equal to the 'possible' number of cpus. I suspect in most cases,
'present' and 'possible' are the same. But it would be good that
other people can share their 'present != possible' configuration
and explain why.

