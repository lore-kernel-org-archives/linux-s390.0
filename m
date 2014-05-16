Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <537645D1.7020403@intel.com>
Date: Fri, 16 May 2014 10:07:29 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
Subject: gather_hugetbl_stats() doesn't use huge_pte...() variants
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux390@de.ibm.com, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Is the numa maps gather_hugetbl_stats() buggy on s390?  It uses the
normal pte_ variants.
