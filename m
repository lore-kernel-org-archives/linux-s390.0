Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99681C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 16 Sep 2021 05:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726B36103B
	for <linux-s390@archiver.kernel.org>; Thu, 16 Sep 2021 05:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhIPFR2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234298AbhIPFR1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Sep 2021 01:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631769367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KaFR0tN7fnlxcmr5XgEGx0dxN0WywjqCKHOBH6+mas=;
        b=friyk0AObk6l2gpK1OUXYq0tLSeiOKA09Xfd/I0MJTtkMx3pPZwI6g+aN93W41L+nxH5f2
        iz0ZvG3v+dnXwdU3ARpv681RBVUec308TaIMHMd4T/TLOxYjtNNdVzjBkBVEA3v1OqzJ/9
        kIWh9LAUX4eNbrPyc8CNUarcCaz1QP4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-x_oqT6s5O4apyRVX-eGZGA-1; Thu, 16 Sep 2021 01:16:06 -0400
X-MC-Unique: x_oqT6s5O4apyRVX-eGZGA-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so1933977wrn.12
        for <linux-s390@vger.kernel.org>; Wed, 15 Sep 2021 22:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KaFR0tN7fnlxcmr5XgEGx0dxN0WywjqCKHOBH6+mas=;
        b=sSfx8gbCBusJJOzvmWaVxeN+JRU1+k+7hwtr76kxLn/re9GEPEKULWTnVzNfZhHvTX
         LYZ9FhwVtBfWk/GVFwxfX5WqQt9IeeLxmBoZ2iGC7b0xGcStzaLSqH2/86Li8LuydhrE
         QmvGQqxIUb+Xgju/JyBrUsR4qEF4R8yzJFVSa+EPcB2smMs9024aiayA3qP2JIuW+qZV
         5Ukv9UnFvrP8kMIZmJMh0b7zr2UiKJkK1dACV2g6CibcpC9DCtBVRDsk4ZgqHlSuSZN/
         CFSeVpwnV22iFBKS28Uc3rgLN6zenQPkrjC7AKWmgNg5lEu2UEI6dRTvQkmLrC02GGU1
         8SSQ==
X-Gm-Message-State: AOAM531YUPe7d5rIAL6T5DmX6rMLE35bZXUk41tPgYdHO/SXZl9WF8g/
        E6fgbOeHaxpYPqdX0LvaIWehoES2I4MioTHSS3eZrnDkJmGd6gbxn3+arGU8h9osyeHm/m5vhCs
        SVNB1vHxwiw51dg4KPTo6zw==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr3071057wmq.39.1631769364702;
        Wed, 15 Sep 2021 22:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7wr3csCaThBnqZG+k1sReSQw2OECASRVpR3W9+CFv3sVgqMd0KKm8+wwp7iqsCYc3nWGJbg==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr3071033wmq.39.1631769364503;
        Wed, 15 Sep 2021 22:16:04 -0700 (PDT)
Received: from thuth.remote.csb (dynamic-046-114-144-075.46.114.pool.telefonica.de. [46.114.144.75])
        by smtp.gmail.com with ESMTPSA id z13sm2315375wrs.90.2021.09.15.22.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 22:16:03 -0700 (PDT)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-s390@vger.kernel.org, Jia He <hejianet@gmail.com>
References: <20210803105937.52052-1-thuth@redhat.com>
 <20210803105937.52052-2-thuth@redhat.com>
 <5e359b28-6233-a97e-a30f-0a30fa516833@redhat.com>
Subject: Re: [PATCH 1/2] sysctl: introduce new proc handler proc_dobool
Message-ID: <4772120f-7bf5-336c-06ef-620b9953f591@redhat.com>
Date:   Thu, 16 Sep 2021 07:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5e359b28-6233-a97e-a30f-0a30fa516833@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/08/2021 11.38, Thomas Huth wrote:
> On 03/08/2021 12.59, Thomas Huth wrote:
>> From: Jia He <hejianet@gmail.com>
>>
>> This is to let bool variable could be correctly displayed in
>> big/little endian sysctl procfs. sizeof(bool) is arch dependent,
>> proc_dobool should work in all arches.
>>
>> Suggested-by: Pan Xinhui <xinhui@linux.vnet.ibm.com>
>> Signed-off-by: Jia He <hejianet@gmail.com>
>> [thuth: rebased the patch to the current kernel version]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/linux/sysctl.h |  2 ++
>>   kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index d99ca99837de..1fa2b69c6fc3 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -48,6 +48,8 @@ typedef int proc_handler(struct ctl_table *ctl, int 
>> write, void *buffer,
>>           size_t *lenp, loff_t *ppos);
>>   int proc_dostring(struct ctl_table *, int, void *, size_t *, loff_t *);
>> +int proc_dobool(struct ctl_table *table, int write, void *buffer,
>> +        size_t *lenp, loff_t *ppos);
>>   int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
>>   int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
>>   int proc_dointvec_minmax(struct ctl_table *, int, void *, size_t *, 
>> loff_t *);
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 272f4a272f8c..25e49b4d8049 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -536,6 +536,21 @@ static void proc_put_char(void **buf, size_t *size, 
>> char c)
>>       }
>>   }
>> +static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
>> +                int *valp,
>> +                int write, void *data)
>> +{
>> +    if (write) {
>> +        *(bool *)valp = *lvalp;
>> +    } else {
>> +        int val = *(bool *)valp;
>> +
>> +        *lvalp = (unsigned long)val;
>> +        *negp = false;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
>>                    int *valp,
>>                    int write, void *data)
>> @@ -798,6 +813,26 @@ static int do_proc_douintvec(struct ctl_table *table, 
>> int write,
>>                      buffer, lenp, ppos, conv, data);
>>   }
>> +/**
>> + * proc_dobool - read/write a bool
>> + * @table: the sysctl table
>> + * @write: %TRUE if this is a write to the sysctl file
>> + * @buffer: the user buffer
>> + * @lenp: the size of the user buffer
>> + * @ppos: file position
>> + *
>> + * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
>> + * values from/to the user buffer, treated as an ASCII string.
>> + *
>> + * Returns 0 on success.
>> + */
>> +int proc_dobool(struct ctl_table *table, int write, void *buffer,
>> +        size_t *lenp, loff_t *ppos)
>> +{
>> +    return do_proc_dointvec(table, write, buffer, lenp, ppos,
>> +                do_proc_dobool_conv, NULL);
>> +}
>> +
>>   /**
>>    * proc_dointvec - read a vector of integers
>>    * @table: the sysctl table
>> @@ -1630,6 +1665,12 @@ int proc_dostring(struct ctl_table *table, int write,
>>       return -ENOSYS;
>>   }
>> +int proc_dobool(struct ctl_table *table, int write,
>> +        void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +    return -ENOSYS;
>> +}
>> +
>>   int proc_dointvec(struct ctl_table *table, int write,
>>             void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>> @@ -3425,6 +3466,7 @@ int __init sysctl_init(void)
>>    * No sense putting this after each symbol definition, twice,
>>    * exception granted :-)
>>    */
>> +EXPORT_SYMBOL(proc_dobool);
>>   EXPORT_SYMBOL(proc_dointvec);
>>   EXPORT_SYMBOL(proc_douintvec);
>>   EXPORT_SYMBOL(proc_dointvec_jiffies);
>>
> 
> Friendly ping!
> 
> Luis, Kees, Iurii, could you please have a look and provide an Ack if this 
> looks ok to you?

Ping again!

Could anybody please provide an Ack?

Thanks,
  Thomas

