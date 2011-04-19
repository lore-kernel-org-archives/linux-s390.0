Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Apr 2011 01:41:14 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [OOPS s390] Unable to handle kernel pointer dereference at
 virtual kernel address (null)
Message-ID: <20110419064114.GA28291@elie>
References: <2099315211.286690.1302917498637.JavaMail.root@md01.wow.synacor.com>
 <20110416014811.GA6150@elie>
 <20110419063400.GA2878@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110419063400.GA2878@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Stephen Powell <zlinuxman@wowway.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Heiko Carstens wrote:

> Ok, I was able to reproduce it and could verify that my patch fixes the bug.

Thanks!

> Cc: Jonathan Nieder <jrnieder@gmail.com>

The patch makes sense to me fwiw.
