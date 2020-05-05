Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 05 May 2020 12:58:05 -0700 (PDT)
Message-Id: <20200505.125805.2022273480111353321.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/2] log state changes and cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200505130121.103272-1-kgraul@linux.ibm.com>
References: <20200505130121.103272-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Tue,  5 May 2020 15:01:19 +0200

> Patch 1 adds the logging of important state changes to enable SMC-R 
> users to detect SMC-R link groups that are not redundant and require
> user actions. Patch 2 is a contribution to clean up an unused inline 
> function.

Please use an appropriate subsystem prefix in your Subject lines for
patch series intro emails, just like you would do for the patches
themselves.

Series applied, thank.
