Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgLRLSz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Dec 2020 06:18:55 -0500
Date: Fri, 18 Dec 2020 12:17:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 6/8] s390x: sie: Add first SIE test
Message-ID: <20201218121717.33c06150.cohuck@redhat.com>
In-Reply-To: <20201211100039.63597-7-frankja@linux.ibm.com>
References: <20201211100039.63597-1-frankja@linux.ibm.com>
        <20201211100039.63597-7-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Fri, 11 Dec 2020 05:00:37 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
