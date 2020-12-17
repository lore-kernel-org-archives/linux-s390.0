Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727694AbgLQJnP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 04:43:15 -0500
Subject: Re: [kvm-unit-tests PATCH v3 6/8] s390x: sie: Add first SIE test
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4581bb7d-145b-4ba4-9192-e29908975411@redhat.com>
Date: Thu, 17 Dec 2020 10:41:40 +0100
MIME-Version: 1.0
In-Reply-To: <20201211100039.63597-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 11/12/2020 11.00, Janosch Frank wrote:
> Let's check if we get the correct interception data on a few
> diags. This commit is more of an addition of boilerplate code than a
> real test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/sie.c         | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |   3 ++
>  3 files changed, 117 insertions(+)
>  create mode 100644 s390x/sie.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
