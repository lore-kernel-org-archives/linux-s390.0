Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A027EC0015E
	for <linux-s390@archiver.kernel.org>; Mon,  3 Jul 2023 08:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGCInd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCInc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Jul 2023 04:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1EBF
        for <linux-s390@vger.kernel.org>; Mon,  3 Jul 2023 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688373769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9j01qwPpErBDT2GubuAl+sX/3Bkrf1KFu3e6uDsu3A=;
        b=SFvNR3N3qeKWUfI4wscBj3iATqNVpA00sRM8RXwQTA4n+OzlfNbDSUXdyAeM1onynSAtpm
        TSY05ztswuYHOcx4xwQgyoHTDGFdfePHMO1jROK1XEom4gcQJzlCIVN8/K7+jx9xJoHG3V
        GM8ue7oymkT9TDxjCWZa89HuC2+8ZJ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-r83WUGHEO-2I2sVQRoN-bA-1; Mon, 03 Jul 2023 04:42:48 -0400
X-MC-Unique: r83WUGHEO-2I2sVQRoN-bA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6349a78b1aaso24571026d6.1
        for <linux-s390@vger.kernel.org>; Mon, 03 Jul 2023 01:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688373768; x=1690965768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9j01qwPpErBDT2GubuAl+sX/3Bkrf1KFu3e6uDsu3A=;
        b=Uen3tbwl5OZ62tMOT5g3vofnvnBqMSc75ZpYlK7PPBF4aBgckik5ielzD4aLck2MgE
         Vj2TqMmw47N+qR34+e7RTPhq2nSGD+VXmMglwsLsnDoLH1M1R2RpRU2aVC+h8BCDCDwH
         2Ut0C9gkqcmbnF+JL2ixw3lfpQ4jzwrnU6USpkIcbWREmgzEn/PMOir4GAfS7piZT9GD
         /5z+yfHIL6rjsuyi8I4cwQMFsIOFjQVJwDO7HmkDiRuC4JG5mtJoB1TDW44KDL31Ue4n
         dxAvs022moWXdn4jm11wL0OpPKpkXQ9G0+SwlIfnpEQPDWhn1I+ulZwSIOCF2JHYEN+M
         EP0w==
X-Gm-Message-State: ABy/qLaneGQhBgWzMgmFvsvEEsFFJNHgG5UNN7XQ1fuglFq97dvNlJgl
        CM7lP63ctpr6sgc5l2YZ9Iar6lyu8ormlm8hY3j8j3kKULNOO6TMeU1Yyz/qUkE/FnX1mcM8VPg
        7zBFOADj86B1OQKq3CVdTOa9kD+ZOkQ==
X-Received: by 2002:a05:6214:2a4a:b0:635:f562:fa1e with SMTP id jf10-20020a0562142a4a00b00635f562fa1emr12570338qvb.30.1688373767940;
        Mon, 03 Jul 2023 01:42:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEg+PvXt3zRvvQF/8LbgMFfXOr/yVak/1Iy7Zlv9ZOHPU6mms7XYBSch3qq3Gqbn+BlsVFLWA==
X-Received: by 2002:a05:6214:2a4a:b0:635:f562:fa1e with SMTP id jf10-20020a0562142a4a00b00635f562fa1emr12570332qvb.30.1688373767735;
        Mon, 03 Jul 2023 01:42:47 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-242.web.vodafone.de. [109.43.178.242])
        by smtp.gmail.com with ESMTPSA id q5-20020ad45ca5000000b00623950fbe48sm11249923qvh.41.2023.07.03.01.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 01:42:47 -0700 (PDT)
Message-ID: <a162644d-f548-7c34-e501-d8080d1d0bef@redhat.com>
Date:   Mon, 3 Jul 2023 10:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [kvm-unit-tests PATCH v10 1/2] s390x: topology: Check the Perform
 Topology Function
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, kvm@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nsg@linux.ibm.com
References: <20230627082155.6375-1-pmorel@linux.ibm.com>
 <20230627082155.6375-2-pmorel@linux.ibm.com>
 <168802854091.40048.12063023827984391132@t14-nrb>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <168802854091.40048.12063023827984391132@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/06/2023 10.49, Nico Boehr wrote:
> Quoting Pierre Morel (2023-06-27 10:21:54)
> [...]
>> diff --git a/s390x/topology.c b/s390x/topology.c
>> new file mode 100644
>> index 0000000..7e1bbf9
>> --- /dev/null
>> +++ b/s390x/topology.c
>> @@ -0,0 +1,190 @@
> [...]
>> +static void check_privilege(int fc)
>> +{
>> +       unsigned long rc;
>> +       char buf[20];
>> +
>> +       snprintf(buf, sizeof(buf), "Privileged fc %d", fc);
>> +       report_prefix_push(buf);
> 
> We have report_prefix_pushf (note the f at the end!) for this.
> 
> I can fix that up when picking in case there's no new version, though.

With that fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>

