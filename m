Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76443C77B7A
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jun 2023 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjFAUrR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFAUrQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jun 2023 16:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DB18D
        for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685652389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKfOoPxKXKTaQ3RA/2u3I6KvcI8YXFqEVhkLpnR7WjE=;
        b=G+XPJJ8t3Gn0vdncwys81GZ7iZzbZp6buFOJ5favAH8aMc8roNghYIbVLvikLV7HRWK7iH
        /fUrwnHtTmhQRTvANhj5OEUoUiq2xmoOpy7lPehERhmDd7LInY0j2vjyha4rPmtdCIaG3s
        p+WYdUBdtuj37NbYHVVu2Uu0cI1lwHQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-gsnhO0j9NfC3THXtYsM_2Q-1; Thu, 01 Jun 2023 16:46:28 -0400
X-MC-Unique: gsnhO0j9NfC3THXtYsM_2Q-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33bf805e901so10394705ab.2
        for <linux-s390@vger.kernel.org>; Thu, 01 Jun 2023 13:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652387; x=1688244387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKfOoPxKXKTaQ3RA/2u3I6KvcI8YXFqEVhkLpnR7WjE=;
        b=dYRjNmEpYYuPluLTAx/OnfVJ6hcGlLFXRjmB5UvkWjdHyqtRRVeFBFn3fwg73gC9tQ
         jexzDit8COlJUB+fLtQqMhEYUnJmk5puIMyfcGDb7DWg8XGQjOsOnw0yHZ/0VmJkxb4r
         vVm/dnj+sv/NnEjjxsK3jW0vK9cYWg7BQ4oF0f+PChiGnlzZEICjUntaeuP6bDH5u3zW
         1o2DFJsoQy2lOn7E9W39oY3/6Hi214bI9+hLgDnm+i5+6IuyjY0ShWWoyPAzBEG+BaLF
         lrXMZfpjCQwY02vyZ3EyjF13DlPyb/M2vo8W3F1uH6/HnIpYA8gZ6YqKsflvj2q/5zVa
         oOYw==
X-Gm-Message-State: AC+VfDyeWwqImfv34QJhsY+KTvqIDXGoe8CvKh4SqIlK+fS0gJZI4IaF
        IsOWdZyE6/XCCM8VsZdNdpUvK6m5rWK7DKkpHBVyMsQoYuJLFwq1bguRyY5oVUYX3Xg3G/MFfLe
        POh8dg5jKRMYU4S5kTaNibg==
X-Received: by 2002:a92:de0e:0:b0:33a:a6de:65be with SMTP id x14-20020a92de0e000000b0033aa6de65bemr5672194ilm.21.1685652387632;
        Thu, 01 Jun 2023 13:46:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ywpMG3vtlHLLEM1U239mV9AK6gm9PprEslu+sHDJULivPRXsgppL7UaHjCclklcKCTTg9FA==
X-Received: by 2002:a92:de0e:0:b0:33a:a6de:65be with SMTP id x14-20020a92de0e000000b0033aa6de65bemr5672186ilm.21.1685652387435;
        Thu, 01 Jun 2023 13:46:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u22-20020a056638135600b00411be337516sm2570727jad.24.2023.06.01.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:46:26 -0700 (PDT)
Date:   Thu, 1 Jun 2023 14:46:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: Re: [PATCH 1/3] vfio: ap: realize the VFIO_DEVICE_GET_IRQ_INFO
 ioctl
Message-ID: <20230601144626.577a94d3.alex.williamson@redhat.com>
In-Reply-To: <20230530223538.279198-2-akrowiak@linux.ibm.com>
References: <20230530223538.279198-1-akrowiak@linux.ibm.com>
        <20230530223538.279198-2-akrowiak@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 30 May 2023 18:35:36 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Realize the VFIO_DEVICE_GET_IRQ_INFO ioctl to retrieve the information for
> the VFIO device request IRQ.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 30 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h         |  9 +++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

