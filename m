Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58683 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfLIQl7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:41:59 -0500
Received: by mail-yw1-f72.google.com with SMTP id l5so1327169ywf.9
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 08:41:58 -0800 (PST)
Date: Mon, 9 Dec 2019 11:41:55 -0500
From: Jeremy Cline <jcline@redhat.com>
Subject: s390 depending on cc-options makes it difficult to configure
Message-ID: <20191209164155.GA78160@dev.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi folks,

Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
makes it difficult to produce an s390 configuration for Fedora and Red
Hat kernels.

The issue is I have the following configurations:

CONFIG_MARCH_Z13=3Dy
CONFIG_TUNE_Z14=3Dy
# CONFIG_TUNE_DEFAULT is not set

When the configuration is prepared on a non-s390x host without a
compiler with -march=3Dz* it changes CONFIG_TUNE_DEFAULT to y which, as
far as I can tell, leads to a kernel tuned for z13 instead of z14.
Fedora and Red Hat build processes produce complete configurations from
snippets on any available host in the build infrastructure which very
frequently is *not* s390.

I did a quick search and couldn't find any other examples of Kconfigs
depending on march or mtune compiler flags and it seems like it'd
generally problematic for people preparing configurations.

Regards,
Jeremy
