Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389517AbgEYJo1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 05:44:27 -0400
Date: Mon, 25 May 2020 11:43:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: stsi: Make output tap13
 compatible
Message-ID: <20200525114335.49bd0b7a.cohuck@redhat.com>
In-Reply-To: <20200525084340.1454-1-frankja@linux.ibm.com>
References: <20200525084340.1454-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, stzi@linux.ibm.com, mhartmay@linux.ibm.com, david@redhat.com

On Mon, 25 May 2020 10:43:40 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> In tap13 output # is a special character and only "skip" and "todo"
> are allowed to come after it. Let's appease our CI environment and
> replace # with "count".
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/stsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
