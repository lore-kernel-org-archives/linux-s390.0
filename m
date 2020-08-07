Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728103AbgHGMNN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Aug 2020 08:13:13 -0400
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200807111555.11169-1-frankja@linux.ibm.com>
 <20200807111555.11169-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da95ddbb-0761-8319-3833-b5f506e87af7@redhat.com>
Date: Fri, 7 Aug 2020 14:12:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200807111555.11169-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 07/08/2020 13.15, Janosch Frank wrote:
> When an exception new psw with a storage key in its mask is loaded
> from lowcore, a specification exception is raised. This differs from
> the behavior when trying to execute skey related instructions, which
> will result in special operation exceptions.
> 
> Also let's add the test to unittests.cfg so it is run more often.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/skrf.c        | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  2 files changed, 83 insertions(+)

It's hot here today, so my review skills might have melted a little bit,
but as far as I can see, it looks fine now:

Reviewed-by: Thomas Huth <thuth@redhat.com>
