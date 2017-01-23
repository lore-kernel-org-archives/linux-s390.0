Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Jan 2017 11:58:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/5] s390/pci: Move an assignment for the variable "ret"
 in s390_pci_mmio_write()
Message-ID: <20170123085858.GL4454@mwanda>
References: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
 <ba783658-2c08-8e92-7f6a-16696c89b476@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba783658-2c08-8e92-7f6a-16696c89b476@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Gerald =?iso-8859-1?Q?Sch=E4fer?= <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The original was more readable.

regards,
dan carpenter
