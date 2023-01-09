Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57DC54EBD
	for <linux-s390@archiver.kernel.org>; Mon,  9 Jan 2023 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjAIIeQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Jan 2023 03:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjAIIdq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Jan 2023 03:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB9A6575
        for <linux-s390@vger.kernel.org>; Mon,  9 Jan 2023 00:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673253186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B24nYPFcuJW8XezitLVfhrLYViIXblQF47qg0cqnbX0=;
        b=MBHfAqg6An7YHKCUYRTApL3SCZsiiaj6G9f+z33tycUdT9L7e5salHa7k8XrE/V1A3rgeQ
        n0BzlZujmH9/KGZZGUW2kfdkYN9wAE4/bzZ2snE56bZCgnzuYdDwQuujHCxJUfQx7bmdIa
        +OyDJWqs8x9BRFKVqtEOf456tXcghL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-EJXiGzb8NkyO3-f-r_WVQQ-1; Mon, 09 Jan 2023 03:33:04 -0500
X-MC-Unique: EJXiGzb8NkyO3-f-r_WVQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F4B0857A81;
        Mon,  9 Jan 2023 08:33:04 +0000 (UTC)
Received: from localhost (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1B962166B26;
        Mon,  9 Jan 2023 08:33:03 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, vneethv@linux.ibm.com
Subject: Re: [PATCH 0/1] docs/ABI: removing those invalid email-addresses
In-Reply-To: <20230102202812.3336171-1-vneethv@linux.ibm.com>
Organization: Red Hat GmbH
References: <20230102202812.3336171-1-vneethv@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Mon, 09 Jan 2023 09:33:00 +0100
Message-ID: <87lemcds5f.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jan 02 2023, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> Hi Conny,
>
> Happy new year.
>
> Let me do this cleanup before i forget again. As suggested, i have
> removed your email-addresses from the sysfs-bus-css file. It make
> sense to remove the invalid email-address and keep the linux-s390 list
> as the primary contact.
>
> Would you like to retain the redhat-id in the driver-override session ?
> I have just deleted that too. Please let me know if you would like to
> keep it.

Thanks, deleting it is fine with me. Not that I have been getting lots
of mail due to it anyway :)

