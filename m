Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED45C4338F
	for <linux-s390@archiver.kernel.org>; Mon,  9 Aug 2021 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446CB6101D
	for <linux-s390@archiver.kernel.org>; Mon,  9 Aug 2021 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhHIPfn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:35:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234708AbhHIPfm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Aug 2021 11:35:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179FY4Rc075279;
        Mon, 9 Aug 2021 11:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hwpA24QRrQlzhRUNEXBLbQJ7FfPUZL9C1vCAfLp04pE=;
 b=YZqSovz5HZpMPAWThi+VH5jqcT24Z1N2g9Zy41tXxVPLLFC3FuapZHFTw9uFQZztfAHV
 TWhSTmZK6miZiVPmafpmmTOXVhTyY+9cWrXTNZJE4fP04VMsaM7+H1poF2qQES4vdyDs
 fkF8MTM28l0QREEDJ4stVRNSizSqKgaA8uw2sSOtxdhs5h1gtPVVVgIjFg2k/UEC+A6s
 ERcmR28aem9wfVa/IxPa3BcFW6qntLcCFM4AwHZEqJSmrpDdOMEm3dBU8w+J9Zbi4y3s
 rZUsXqGoSPy6ImuFHPxDs6YnC7B5dVN7SXUHmcUg+1VKGAacs+qZwAkDDUvrQ/1mQNFI EA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j8ae59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 11:35:14 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179FXfR7021136;
        Mon, 9 Aug 2021 15:35:13 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3a9htbuvn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 15:35:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179FZC3l38338886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 15:35:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA53C7E6B0;
        Mon,  9 Aug 2021 15:12:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DB8A7E6AD;
        Mon,  9 Aug 2021 15:12:54 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 15:12:53 +0000 (GMT)
Subject: Re: [PATCH] s390/crypto: fix all kernel-doc warnings in vfio_ap_ops.c
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
Cc:     kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20210806050149.9614-1-rdunlap@infradead.org>
 <d8f1b065-f7b2-a0f3-f87a-ffdd2f7f2781@linux.ibm.com>
 <1ad57c8d-c0d1-88d9-bcce-3d3501455d8e@infradead.org>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <fd938029-7d87-4e65-bb2c-b78e9b0175e3@linux.ibm.com>
Date:   Mon, 9 Aug 2021 11:12:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1ad57c8d-c0d1-88d9-bcce-3d3501455d8e@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J_k2VTnUT-tNXFNifIgL6PE91Otx9YWF
X-Proofpoint-ORIG-GUID: J_k2VTnUT-tNXFNifIgL6PE91Otx9YWF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_05:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090113
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thanks Randy.

On 8/6/21 9:38 PM, Randy Dunlap wrote:
> On 8/6/21 6:26 AM, Tony Krowiak wrote:
>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Pardon my ignorance, but this is the first I've seen of kernel-doc 
>> warnings.
>> Is there a flag I can set when I build to get kernel-doc warnings? Is 
>> there a tool I can run?
>> Where is the kernel-doc format documented? I'd like to avoid this in 
>> the future.
>
> Hi,
>
> Here is the 0day bot report:
> https://lore.kernel.org/lkml/202108010650.DLRzJOtm-lkp@intel.com/
> (not sent to any of your group, sadly).
>
> kernel-doc format is documented in 
> Documentation/doc-guide/kernel-doc.rst.
>
> The 0day bot lists the reproduction steps. It used clang but I used
> gcc. Shouldn't matter in this case. The main point from the 0day bot
> is that "this is a W=1 build".  Using W=1 causes checks for extra
> C compiler warnings and also it causes checks for documentation build
> errors/warnings.
>
> In your build environment, using "make W=1 ARCH=s390 allmodconfig all"
> will produce lots of output (both compiler and kernel-doc output).
> I suppose that is the expected way to do it.
>
> AFAIK there is no support for something like "make W=1 htmldocs"
> to just check for kernel-doc errors/warnings in source files, so what
> I do when I am targeting only one source file is something like what
> is documented in the file referenced above:
>
> "Running the ``kernel-doc`` tool with increased verbosity and without 
> actual
> output generation may be used to verify proper formatting of the
> documentation comments. For example::
>
>     scripts/kernel-doc -v -none drivers/foo/bar.c
> "
> and then I script that for ease of use.
> Using the latter command reports lots more kernel-doc warnings than
> the 0day bot reported, so I fixed all of them that it found.
>
>
> HTH.
>
>
>> On 8/6/21 1:01 AM, Randy Dunlap wrote:
>>> The 0day bot reported some kernel-doc warnings in this file so clean up
>>> all of the kernel-doc and use proper kernel-doc formatting.
>>> There are no more kernel-doc errors or warnings reported in this file.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Cc: Halil Pasic <pasic@linux.ibm.com>
>>> Cc: Jason Herne <jjherne@linux.ibm.com>
>>> Cc: Harald Freudenberger <freude@linux.ibm.com>
>>> Cc: linux-s390@vger.kernel.org
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c |  116 ++++++++++++----------------
>>>   1 file changed, 52 insertions(+), 64 deletions(-)
>
>

