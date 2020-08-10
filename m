Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgHJOiw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 Aug 2020 10:38:52 -0400
Date: Mon, 10 Aug 2020 16:38:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: skrf: Add exception new
 skey test and add test to unittests.cfg
Message-ID: <20200810163840.1eebeeb3.cohuck@redhat.com>
In-Reply-To: <20200807111555.11169-3-frankja@linux.ibm.com>
References: <20200807111555.11169-1-frankja@linux.ibm.com>
        <20200807111555.11169-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Fri,  7 Aug 2020 07:15:54 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

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

Didn't review deeply.

Acked-by: Cornelia Huck <cohuck@redhat.com>
