Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729203AbfHTN5E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 09:57:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KDv1OA033413
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 09:57:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ughxq8tdq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 09:57:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 14:56:51 +0100
Subject: Re: [bug report] s390/qeth: streamline SNMP cmd code
References: <20190820110504.GA1847@mwanda>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Tue, 20 Aug 2019 15:56:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190820110504.GA1847@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <95addda5-aa7e-32f3-0665-42fb7847788a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-s390@vger.kernel.org, Kees Cook <keescook@chromium.org>, Ursula Braun <ubraun@linux.ibm.com>

On 20.08.19 13:05, Dan Carpenter wrote:
> [  Kees, could we make copy_from_user() just fail if size is more than
>    INT_MAX? ]
> 
> Hello Julian Wiedmann,
> 

Heya Dan - thanks! Agreed, that looks wrong. I'll put together a fix...


> The patch d4c08afafa04: "s390/qeth: streamline SNMP cmd code" from
> Jun 27, 2019, leads to the following static checker warning:
> 
> 	drivers/s390/net/qeth_core_main.c:4381 qeth_snmp_command()
> 	error: check that 'req_len' is capped
> 
> drivers/s390/net/qeth_core_main.c
>   4355  static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
>   4356  {
>   4357          struct qeth_snmp_ureq __user *ureq;
>   4358          struct qeth_cmd_buffer *iob;
>   4359          unsigned int req_len;
>   4360          struct qeth_arp_query_info qinfo = {0, };
>   4361          int rc = 0;
>   4362  
>   4363          QETH_CARD_TEXT(card, 3, "snmpcmd");
>   4364  
>   4365          if (IS_VM_NIC(card))
>   4366                  return -EOPNOTSUPP;
>   4367  
>   4368          if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
>   4369              IS_LAYER3(card))
>   4370                  return -EOPNOTSUPP;
>   4371  
>   4372          ureq = (struct qeth_snmp_ureq __user *) udata;
>   4373          if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
>   4374              get_user(req_len, &ureq->hdr.req_len))
>   4375                  return -EFAULT;
>   4376  
>   4377          iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
> 
> The problem is that qeth_get_adapter_cmd() doesn't guard against integer
> overflows if reg_len is >= UINT_MAX - offsetof(struct qeth_ipacmd_setadpparms,
> data)).
> 
>   4378          if (!iob)
>   4379                  return -ENOMEM;
>   4380  
>   4381          if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
>   4382                             &ureq->cmd, req_len)) {
> 
> So then this copy_from_user() could overflow.  The original code had a
> similar problem but it only affect 32 bit systems.  I'm not sure what is
> a good upper bound for req_len.
> 
>   4383                  qeth_put_cmd(iob);
>   4384                  return -EFAULT;
>   4385          }
>   4386  
>   4387          qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
> 
> regards,
> dan carpenter
> 
